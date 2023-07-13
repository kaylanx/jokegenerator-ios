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

        XCTAssertEqual("The joke", jokesViewViewModel.joke)
        XCTAssertNil(jokesViewViewModel.punchline)
        XCTAssertFalse(jokesViewViewModel.showPunchline)
        XCTAssertFalse(jokesViewViewModel.showPunchlineButtonVisible)
    }

    func testNewTwoPartJokeReturned() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .twopart(setup: "The setup", delivery: "The punchline"))
        await jokesViewViewModel.getNewJoke()

        XCTAssertEqual("The setup", jokesViewViewModel.joke)
        XCTAssertEqual("The punchline", jokesViewViewModel.punchline)
        XCTAssertFalse(jokesViewViewModel.showPunchline)
        XCTAssertTrue(jokesViewViewModel.showPunchlineButtonVisible)
    }

    func testWhenFirstJokeIsTwoPartAndSecondJokeIsSingleThenPunchlineIsNil() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .twopart(setup: "The setup", delivery: "The punchline"))
        await jokesViewViewModel.getNewJoke()

        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .single(joke: "The joke"))
        await jokesViewViewModel.getNewJoke()

        XCTAssertEqual("The joke", jokesViewViewModel.joke)
        XCTAssertNil(jokesViewViewModel.punchline)
        XCTAssertFalse(jokesViewViewModel.showPunchline)
        XCTAssertFalse(jokesViewViewModel.showPunchlineButtonVisible)
    }

    func testWhenJokeIsTwoPartAndRevealPunchlineTappedThenPunchlineIsShown() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .twopart(setup: "The setup", delivery: "The punchline"))
        await jokesViewViewModel.getNewJoke()

        XCTAssertFalse(jokesViewViewModel.showPunchline)
        XCTAssertTrue(jokesViewViewModel.showPunchlineButtonVisible)

        jokesViewViewModel.showPunchlineTapped()
        XCTAssertTrue(jokesViewViewModel.showPunchline)
        XCTAssertFalse(jokesViewViewModel.showPunchlineButtonVisible)
    }

    func testWhenJokeIsSingleAndRevealPunchlineTappedThenPunchlineIsNotShown() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .single(joke: "The joke"))
        await jokesViewViewModel.getNewJoke()

        XCTAssertFalse(jokesViewViewModel.showPunchline)
        XCTAssertFalse(jokesViewViewModel.showPunchlineButtonVisible)

        jokesViewViewModel.showPunchlineTapped()
        XCTAssertFalse(jokesViewViewModel.showPunchline)
        XCTAssertFalse(jokesViewViewModel.showPunchlineButtonVisible)
    }

    func testAfterPunchlineShownWhenGetNewJokeCalledPunchlineIsHidden() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .twopart(setup: "The setup", delivery: "The punchline"))
        await jokesViewViewModel.getNewJoke()

        XCTAssertFalse(jokesViewViewModel.showPunchline)

        jokesViewViewModel.showPunchlineTapped()
        XCTAssertTrue(jokesViewViewModel.showPunchline)

        await jokesViewViewModel.getNewJoke()
        XCTAssertFalse(jokesViewViewModel.showPunchline)
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
