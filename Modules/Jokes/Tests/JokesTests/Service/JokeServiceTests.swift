import Testing

@testable import Jokes

struct JokeServiceTests {

    private let stubJokeRepository = StubJokeRepository()
    private let stubJokeDtoAdapter = StubJokeDtoAdapting()
    private let jokeService: JokeServiceImpl

    init() {
        stubJokeRepository.stubbedJokeResult = JokesTestHelper.createJokeDto()
        stubJokeDtoAdapter.stubbedAdaptResult = JokesTestHelper.createJoke()
        jokeService = JokeServiceImpl(jokeRepository: stubJokeRepository, jokeDtoAdapter: stubJokeDtoAdapter)
    }

    @Test
    func servicePassesDataToCorrectServices() async throws {
        let joke = try await jokeService.joke(for: .any)

        #expect(stubJokeRepository.invokedJoke == true)
        #expect(stubJokeDtoAdapter.invokedAdapt == true)

        let (category, _) = try #require(stubJokeRepository.invokedJokeParameters)
        #expect(category == .any)

        let (jokeDto, _) = try #require(stubJokeDtoAdapter.invokedAdaptParameters)
        #expect(jokeDto.id == stubJokeRepository.stubbedJokeResult.id)
        #expect(jokeDto.category == stubJokeRepository.stubbedJokeResult.category)

        #expect(joke.id == stubJokeDtoAdapter.stubbedAdaptResult.id)
    }
}
