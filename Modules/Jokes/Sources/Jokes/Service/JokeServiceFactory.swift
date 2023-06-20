import Foundation

protocol JokeServiceFactory {
    func jokeService() -> JokeService
}

final class JokeServiceFactoryImpl: JokeServiceFactory {

    private let jokeRepository: JokeRepository
    private let jokeDtoAdapting: JokeDtoAdapting

    init(jokeRepository: JokeRepository, jokeDtoAdapting: JokeDtoAdapting) {
        self.jokeRepository = jokeRepository
        self.jokeDtoAdapting = jokeDtoAdapting
    }

    func jokeService() -> JokeService {
        JokeServiceImpl(jokeRepository: jokeRepository, jokeDtoAdapter: jokeDtoAdapting)
    }
}
