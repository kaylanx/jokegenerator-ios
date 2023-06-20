import Foundation

@testable import Jokes

final class StubJokeDtoAdapting: JokeDtoAdapting {

    var invokedAdapt = false
    var invokedAdaptCount = 0
    var invokedAdaptParameters: (jokeDto: JokeDto, Void)?
    var invokedAdaptParametersList = [(jokeDto: JokeDto, Void)]()
    var stubbedAdaptError: Error?
    var stubbedAdaptResult: Joke!

    func adapt(jokeDto: JokeDto) throws -> Joke {
        invokedAdapt = true
        invokedAdaptCount += 1
        invokedAdaptParameters = (jokeDto, ())
        invokedAdaptParametersList.append((jokeDto, ()))
        if let error = stubbedAdaptError {
            throw error
        }
        return stubbedAdaptResult
    }
}
