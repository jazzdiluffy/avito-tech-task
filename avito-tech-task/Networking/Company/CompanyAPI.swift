import Foundation

enum CompanyAPI: API {
    
    case companyInfo
    
    var scheme: RequestScheme {
        switch self {
        case .companyInfo:
            return .https
        }
    }
    
    var baseURLofAPI: String {
        switch self {
        case .companyInfo:
            return "run.mocky.io"
        }
    }
    
    var pathOfAPI: String {
        switch self {
        case .companyInfo:
            return "/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        }
    }
    
    var parametersOfAPI: [URLQueryItem] {
        switch self {
        case .companyInfo:
            return []
        }
    }
    
    var httpAPImethod: HttpMethodOfAPI {
        switch self {
        case .companyInfo:
            return .GET
        }
    }
}
