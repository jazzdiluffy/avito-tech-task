import Foundation

final class CompanyNetworkingService {
    typealias Minutes = Int
    
    static let shared = CompanyNetworkingService()
    private init() { }
    
    private let cacheService = CacheService.shared
    private let cacheLiveTime: Minutes = 60
    
    struct CompanyResponseModel: Codable {
        let company: Company
    }
    
    func getCompanyInfo(completion: @escaping (Result<Company, Error>) -> ()) {
        if let company = lookInCache() {
            completion(.success(company))
            return
        }
        let endpoint: CompanyAPI = .companyInfo
        NetworkService.request(endpoint: endpoint) { [weak self]
            (result: Result<CompanyResponseModel, Error>) in
            switch result {
            case .success(let response):
                let company = response.company
                self?.cacheService.write(data: company)
                completion(.success(company))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func lookInCache() -> Company? {
        if let modDate = cacheService.lastDateOfModification(),
           let minutes = Date.minutes(startingFrom: modDate),
           minutes <= cacheLiveTime {
            if let company = cacheService.load(Company.self) {
                return company
            }
        }
        return nil
    }
}

