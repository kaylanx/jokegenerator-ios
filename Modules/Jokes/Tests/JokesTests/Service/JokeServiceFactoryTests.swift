import Testing

@testable import Jokes

struct JokeServiceFactoryTests {

    private let stubJokeRepository = StubJokeRepository()
    private let stubJokeDtoAdapter = StubJokeDtoAdapting()

    @Test
    func factoryReturnsJokeServiceImpl() throws {
        let factory = JokeServiceFactoryImpl(jokeRepository: stubJokeRepository, jokeDtoAdapting: stubJokeDtoAdapter)
        let jokeService = factory.jokeService()
        #expect(jokeService is JokeServiceImpl, "jokeService should be instance of JokeServiceImpl")
    }
}
