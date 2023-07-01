import Combine
import XCTest

import ViewModel
import Jokes

@testable import JokeGenerator

@MainActor
final class AppJokesViewViewModelTests: XCTestCase {

    var stubJokeService = StubJokeService()
    var jokesViewViewModel: AppJokesViewViewModel!

    override func setUpWithError() throws {
        jokesViewViewModel = AppJokesViewViewModel(jokeService: stubJokeService)
    }

    func testNewSingleJokeReturned() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .single(joke: "The joke"))
        await jokesViewViewModel.getNewJoke()

        XCTAssertEqual("The joke", jokesViewViewModel.state.joke)
        XCTAssertNil(jokesViewViewModel.state.punchline)
    }

    func testNewTwoPartJokeReturned() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .twopart(setup: "The setup", delivery: "The punchline"))
        await jokesViewViewModel.getNewJoke()

        XCTAssertEqual("The setup", jokesViewViewModel.state.joke)
        XCTAssertEqual("The punchline", jokesViewViewModel.state.punchline)
    }
}

final class StubJokeService: JokeService {

    var invokedJoke = false
    var invokedJokeCount = 0
    var invokedJokeParameters: (category: JokeCategory, Void)?
    var invokedJokeParametersList = [(category: JokeCategory, Void)]()
    var stubbedJokeResult: Joke!
    var stubbedJokeError: Error?

    func joke(for category: JokeCategory) async throws -> Joke {
        invokedJoke = true
        invokedJokeCount += 1
        invokedJokeParameters = (category, ())
        invokedJokeParametersList.append((category, ()))

        if let stubbedJokeError {
            throw stubbedJokeError
        }

        return stubbedJokeResult
    }
}
