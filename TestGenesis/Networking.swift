import UIKit
protocol NetworkingProtocol {
    func search(_ queryParam: String, pageNumber: Int, handler: @escaping ([User])-> ())
    
}
class Networking: NetworkingProtocol {
    func search(_ queryParam: String, pageNumber: Int, handler: @escaping ([User]) -> ()) {
        guard let urlString = URL(string:        "https://api.github.com/search/repositories?q=stars%3A%3E0&sort=stars&order=\(queryParam)&page=\(pageNumber)&per_page=30") else {return}
        
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            
            guard let data = data else {return}
            print(data)
            do{
                let dataJson = try JSONDecoder().decode(Items.self, from: data)
                print(dataJson)
                DispatchQueue.main.async {
                handler(dataJson.items)
                }
            }catch let error{
                print(error)
            }
        }.resume()
    }
}
