import Foundation

struct JokeDto: Decodable {
    let id: Int?
    let category: String?
    let type: String?
    let joke: String?
    let setup: String?
    let delivery: String?
    let flags: Flags?
    let safe: Bool?
    let lang: String?

    let error: Bool?
    let internalError: Bool?
    let code: Int?
    let message: String?
    let causedBy: [String]?
    let additionalInfo: String?
    let timestamp: Int?

    struct Flags: Decodable {
        let nsfw: Bool?
        let religious: Bool?
        let political: Bool?
        let racist: Bool?
        let sexist: Bool?
        let explicit: Bool?
    }
}
