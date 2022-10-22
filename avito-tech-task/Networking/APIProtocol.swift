import Foundation

protocol API {
    var scheme: RequestScheme { get }
    var baseURLofAPI: String { get }
    var pathOfAPI: String { get }
    var parametersOfAPI: [URLQueryItem] { get }
    var httpAPImethod: HttpMethodOfAPI { get }
}

enum RequestScheme: String {
    case http
    case https
}

enum HttpMethodOfAPI: String {
    case GET
    case POST
    case DELETE
    case PATCH
    case PUT
}
