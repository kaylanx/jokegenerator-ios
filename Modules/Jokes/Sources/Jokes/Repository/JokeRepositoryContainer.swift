import Foundation

import RequestMaker

final class JokeRepositoryContainer {
    let jokeRepository: JokeRepository

    init(requestMakerFactory: RequestMakerFactory) {
        let requestMaker = requestMakerFactory.requestMaker()
        let jsonJokeRepositoryFactory = JsonJokeRepositoryFactory(requestMaker: requestMaker)
        jokeRepository = jsonJokeRepositoryFactory.jokeRepository()
    }
}
