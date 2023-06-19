import Foundation

enum JokeRepositoryError: Error {
    case `internal`(JokeErrorDetails)
    case client(JokeErrorDetails)

    struct JokeErrorDetails {
        let code: Int?
        let message: String?
        let causedBy: [String]?
        let additionalInfo: String?
        let timestamp: Int?
    }
}

protocol JokeRepository {
    func joke(for category: JokeCategory) async throws -> JokeDto
}
