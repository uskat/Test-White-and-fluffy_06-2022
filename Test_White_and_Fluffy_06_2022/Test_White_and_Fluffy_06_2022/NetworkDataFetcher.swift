
import Foundation

class NetworkDataFetcher {
    
    var network = Network()
    
    func fetchImage(searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        network.requestDataForURL(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Ошибка в полученных данных: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Ошибка в декодировании данных формата JSON: ", jsonError)
            return nil
        }
    }
}
