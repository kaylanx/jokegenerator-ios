import Foundation

enum JokeCategory: String {
    case any
}

protocol JokeRepository {
    func joke(for category: JokeCategory) async throws -> JokeDto
}
