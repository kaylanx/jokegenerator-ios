import Foundation

import RequestMaker

final public class JokeServiceContainer {
    public let jokeService: JokeService

    let repositoryContainer: JokeRepositoryContainer

    public init(requestMakerFactory: RequestMakerFactory) {
        repositoryContainer = JokeRepositoryContainer(requestMakerFactory: requestMakerFactory)

        let jokeDtoAdapter = JokeDtoAdapter()
        let jokeServiceFactory = JokeServiceFactoryImpl(jokeRepository: repositoryContainer.jokeRepository, jokeDtoAdapting: jokeDtoAdapter)

        jokeService = jokeServiceFactory.jokeService()
    }
}
