import XCTest

import RequestMakerTestHelper

@testable import Jokes

final class JsonJokeRepositoryFactoryTests: XCTestCase {

    func testFactoryReturnsJsonJokeRepository() throws {
        let requestMaker = StubRequestMaker()
        let factory = JsonJokeRepositoryFactory(requestMaker: requestMaker)
        let jokeRepository = factory.jokeRepository()
        XCTAssertTrue(jokeRepository is JsonJokeRepository, "jokeRepository should be instance of JsonJokeRepository")
    }
}
