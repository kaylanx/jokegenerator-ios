import Testing

import RequestMakerTestHelper

@testable import Jokes

struct JsonJokeRepositoryFactoryTests {

    @Test
    func factoryReturnsJsonJokeRepository() throws {
        let requestMaker = StubRequestMaker()
        let factory = JsonJokeRepositoryFactory(requestMaker: requestMaker)
        let jokeRepository = factory.jokeRepository()
        #expect(jokeRepository is JsonJokeRepository, "jokeRepository should be instance of JsonJokeRepository")
    }
}
