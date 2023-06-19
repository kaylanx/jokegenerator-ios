import Foundation

import RequestMaker

protocol JokeRepositoryFactory {
    func jokeRepository() -> JokeRepository
}

final class JsonJokeRepositoryFactory: JokeRepositoryFactory {

    private let requestMaker: RequestMaker

    init(requestMaker: RequestMaker) {
        self.requestMaker = requestMaker
    }

    func jokeRepository() -> JokeRepository {
        JsonJokeRepository(requestMaker: requestMaker)
    }
}
