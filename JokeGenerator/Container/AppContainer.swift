import Foundation

import RequestMaker
import Jokes

final class AppContainer {
    let jokeServiceContainer: JokeServiceContainer
    let appViewModelFactory: ViewModelFactory
    let appViewFactory: ViewFactory

    init() {
        let requestMakerFactory = AppRequestMakerFactory()
        jokeServiceContainer = JokeServiceContainer(requestMakerFactory: requestMakerFactory)
        appViewModelFactory = AppViewModelFactory(jokeServiceContainer: jokeServiceContainer)
        appViewFactory = AppViewFactory(viewModelFactory: appViewModelFactory)
    }
}
