import UIKit

struct Items: Decodable {
    var items: [User]
}

struct User: Decodable {
    
    var full_name: String
    var owner: Owner
    var html_url : String
    var isWatch: Bool? = false
    
    struct Owner: Decodable {
        var repos_url: String
        var avatar_url: String
    }
}
