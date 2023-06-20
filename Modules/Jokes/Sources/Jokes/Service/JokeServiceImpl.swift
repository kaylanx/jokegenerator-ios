import Foundation

final class JokeServiceImpl: JokeService {

    private let jokeRepository: JokeRepository
    private let jokeDtoAdapter: JokeDtoAdapting

    init(jokeRepository: JokeRepository, jokeDtoAdapter: JokeDtoAdapting) {
        self.jokeRepository = jokeRepository
        self.jokeDtoAdapter = jokeDtoAdapter
    }

    func joke(for category: JokeCategory) async throws -> Joke {
        let jokeDto = try await jokeRepository.joke(for: category)
        let joke = try jokeDtoAdapter.adapt(jokeDto: jokeDto)
        return joke
    }
}
