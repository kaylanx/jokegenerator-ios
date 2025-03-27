import Testing

import Jokes

@testable import JokeGenerator

@MainActor
struct AppJokesViewViewModelTests {

    private let stubJokeService = StubJokeService()
    private let jokesViewViewModel: AppJokesViewViewModel

    init() {
        jokesViewViewModel = AppJokesViewViewModel(jokeService: stubJokeService)
    }

    @Test
    func newSingleJokeReturned() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .single(joke: "The joke"))
        await jokesViewViewModel.getNewJoke()

        #expect(jokesViewViewModel.joke == "The joke")
        #expect(jokesViewViewModel.punchline == nil)
        #expect(jokesViewViewModel.showPunchline == false)
        #expect(jokesViewViewModel.showPunchlineButtonVisible == false)
    }

    @Test
    func newTwoPartJokeReturned() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .twopart(setup: "The setup", delivery: "The punchline"))
        await jokesViewViewModel.getNewJoke()

        #expect(jokesViewViewModel.joke == "The setup")
        #expect(jokesViewViewModel.punchline == "The punchline")
        #expect(jokesViewViewModel.showPunchline == false)
        #expect(jokesViewViewModel.showPunchlineButtonVisible == true)
    }

    @Test
    func whenFirstJokeIsTwoPartAndSecondJokeIsSingleThenPunchlineIsNil() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .twopart(setup: "The setup", delivery: "The punchline"))
        await jokesViewViewModel.getNewJoke()

        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .single(joke: "The joke"))
        await jokesViewViewModel.getNewJoke()

        #expect(jokesViewViewModel.joke == "The joke")
        #expect(jokesViewViewModel.punchline == nil)
        #expect(jokesViewViewModel.showPunchline == false)
        #expect(jokesViewViewModel.showPunchlineButtonVisible == false)
    }

    @Test
    func whenJokeIsTwoPartAndRevealPunchlineTappedThenPunchlineIsShown() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .twopart(setup: "The setup", delivery: "The punchline"))
        await jokesViewViewModel.getNewJoke()

        #expect(jokesViewViewModel.showPunchline == false)
        #expect(jokesViewViewModel.showPunchlineButtonVisible == true)

        jokesViewViewModel.showPunchlineTapped()
        #expect(jokesViewViewModel.showPunchline == true)
        #expect(jokesViewViewModel.showPunchlineButtonVisible == false)
    }

    @Test
    func whenJokeIsSingleAndRevealPunchlineTappedThenPunchlineIsNotShown() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .single(joke: "The joke"))
        await jokesViewViewModel.getNewJoke()

        #expect(jokesViewViewModel.showPunchline == false)
        #expect(jokesViewViewModel.showPunchlineButtonVisible == false)

        jokesViewViewModel.showPunchlineTapped()
        #expect(jokesViewViewModel.showPunchline == false)
        #expect(jokesViewViewModel.showPunchlineButtonVisible == false)
    }

    @Test
    func afterPunchlineShownWhenGetNewJokeCalledPunchlineIsHidden() async throws {
        stubJokeService.stubbedJokeResult = Joke(id: 1, category: .any, details: .twopart(setup: "The setup", delivery: "The punchline"))

        await jokesViewViewModel.getNewJoke()
        #expect(jokesViewViewModel.showPunchline == false)

        jokesViewViewModel.showPunchlineTapped()
        #expect(jokesViewViewModel.showPunchline == true)

        await jokesViewViewModel.getNewJoke()
        #expect(jokesViewViewModel.showPunchline == false)
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
