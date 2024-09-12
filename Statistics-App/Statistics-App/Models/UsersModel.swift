
import Foundation

struct Users: Codable {
    let users: [User]
}

// MARK: - User
struct User: Codable {
    let id: Int
    let sex, username: String
    let isOnline: Bool
    let age: Int
    let file: [File]
    
    enum CodingKeys: String, CodingKey {
        case id, sex, username, isOnline, age
        case file = "files"
    }
    
}

// MARK: - File
struct File: Codable {
    let id: Int
    let url: String
    let type: String
}
