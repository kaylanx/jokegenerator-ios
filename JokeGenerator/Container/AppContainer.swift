import Foundation

import RequestMaker
import Jokes

final class AppContainer {
    let jokeServiceContainer: JokeServiceContainer

    init() {
        let requestMakerFactory = AppRequestMakerFactory()
        jokeServiceContainer = JokeServiceContainer(requestMakerFactory: requestMakerFactory)
    }
}
