import Foundation

@testable import Jokes

final class StubJokeRepository: JokeRepository {

    var invokedJoke = false
    var invokedJokeCount = 0
    var invokedJokeParameters: (category: JokeCategory, Void)?
    var invokedJokeParametersList = [(category: JokeCategory, Void)]()
    var stubbedJokeError: Error?
    var stubbedJokeResult: JokeDto!

    func joke(for category: JokeCategory) async throws -> JokeDto {
        invokedJoke = true
        invokedJokeCount += 1
        invokedJokeParameters = (category, ())
        invokedJokeParametersList.append((category, ()))

        if let error = stubbedJokeError {
            throw error
        }

        return stubbedJokeResult
    }
}
