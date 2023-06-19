import Foundation

public enum JokeServiceError: Error {
    case `internal`
    case client
}

public protocol JokeService {
    func joke(for category: JokeCategory) async throws -> Joke
}
