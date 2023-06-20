import XCTest

@testable import Jokes

final class JokeServiceTests: XCTestCase {

    private let stubJokeRepository = StubJokeRepository()
    private let stubJokeDtoAdapter = StubJokeDtoAdapting()
    private var jokeService: JokeServiceImpl!

    override func setUpWithError() throws {
        stubJokeRepository.stubbedJokeResult = JokesTestHelper.createJokeDto()
        stubJokeDtoAdapter.stubbedAdaptResult = JokesTestHelper.createJoke()
        jokeService = JokeServiceImpl(jokeRepository: stubJokeRepository, jokeDtoAdapter: stubJokeDtoAdapter)
    }

    func testServicePassesDataToCorrectServices() async throws {
        let joke = try await jokeService.joke(for: .any)

        XCTAssertTrue(stubJokeRepository.invokedJoke)
        XCTAssertTrue(stubJokeDtoAdapter.invokedAdapt)

        let (category, _) = try XCTUnwrap(stubJokeRepository.invokedJokeParameters)
        XCTAssertEqual(category, .any)

        let (jokeDto, _) = try XCTUnwrap(stubJokeDtoAdapter.invokedAdaptParameters)
        XCTAssertEqual(jokeDto.id, stubJokeRepository.stubbedJokeResult.id)
        XCTAssertEqual(jokeDto.category, stubJokeRepository.stubbedJokeResult.category)

        XCTAssertEqual(joke.id, stubJokeDtoAdapter.stubbedAdaptResult.id)
    }
}
