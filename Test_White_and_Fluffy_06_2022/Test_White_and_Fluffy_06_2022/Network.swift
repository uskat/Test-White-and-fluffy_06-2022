
import Foundation

class Network {
    
//MARK: - =================================== METHODs ===================================
    func requestDataForURL(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.queryItemsPreparation(searchTerm: searchTerm)
        let url = self.urlAdress(parameters: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = createHeader()
        request.httpMethod = "get"
        let myTask = createDataTask(from: request, completion: completion)
        myTask.resume()
    }
    
    private func createHeader() -> [String: String] {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID z1emz5dEBZhQRuxjuOqWfu8w7rFJ1gpBK-nCXI_3Gh8"
        return headers
    }
    
    private func urlAdress(parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    private func queryItemsPreparation(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(20)
        return parameters
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}




