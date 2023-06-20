import XCTest

@testable import Jokes

final class JokeServiceFactoryTests: XCTestCase {

    private let stubJokeRepository = StubJokeRepository()
    private let stubJokeDtoAdapter = StubJokeDtoAdapting()

    func testFactoryReturnsJokeServiceImpl() throws {
        let factory = JokeServiceFactoryImpl(jokeRepository: stubJokeRepository, jokeDtoAdapting: stubJokeDtoAdapter)
        let jokeService = factory.jokeService()
        XCTAssertTrue(jokeService is JokeServiceImpl, "jokeService should be instance of JokeServiceImpl")
    }
}
