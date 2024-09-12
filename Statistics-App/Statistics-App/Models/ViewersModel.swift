
import Foundation

// MARK: - StatisticsViewers
struct StatisticsViewers: Codable {
    let statistics: [Statistic]
}

// MARK: - Statistic
struct Statistic: Codable {
    let userID: Int
    let type: String
    let dates: [Int]

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case type, dates
    }
}
