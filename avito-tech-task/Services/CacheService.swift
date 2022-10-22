import Foundation

class CacheService {
    
    static let shared = CacheService()
    private init() { }
    
    private let fileManager = FileManager.default
    private let decoder = PropertyListDecoder()
    private let encoder = PropertyListEncoder()
    
    private var plistURL: URL? {
        let doc = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let pathComponent = "saved.plist"
        return doc?.appendingPathComponent(pathComponent)
    }
    
    func load<T: Decodable>(_ t: T.Type) -> T? {
        guard let plistURL = plistURL, let data = try? Data.init(contentsOf: plistURL) else {
            return nil
        }
        return try? decoder.decode(T.self, from: data)
    }
    
    func lastDateOfModification() -> Date? {
        guard let plistURL = plistURL else { return nil }
        let attributes = try? fileManager.attributesOfItem(atPath: plistURL.path)
        return attributes?[FileAttributeKey.modificationDate] as? Date
    }
    
    func write<T: Encodable>(data: T) {
        guard let plistURL = plistURL, let data = try? encoder.encode(data) else {
            return
        }
        
        if fileManager.fileExists(atPath: plistURL.path) {
            try? data.write(to: plistURL, options: .atomic)
        } else {
            fileManager.createFile(atPath: plistURL.path, contents: data, attributes: nil)
        }
    }
}
