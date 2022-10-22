import Foundation

final class NetworkService {
    
    private class func buildURLComponents(_ endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURLofAPI
        components.path = endpoint.pathOfAPI
        components.queryItems = endpoint.parametersOfAPI
        return components
    }
    
    class func request<T: Decodable>(endpoint: API, completion: @escaping (Result<T, Error>) -> Void) {
        let components = buildURLComponents(endpoint)
        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpAPImethod.rawValue
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, response != nil else {
                return
            }

            if let decodedObject = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(decodedObject))
            } else {
                let decodeError = NSError(
                    domain: "com.ilyaB.avito-tech-task",
                    code: 200,
                    userInfo: [NSLocalizedDescriptionKey: "Failure"]
                )
                completion(.failure(decodeError))
            }
        }
        dataTask.resume()
    }
}
