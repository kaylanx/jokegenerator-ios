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
        appViewModelFactory = AppViewModelFactory()
        appViewFactory = AppViewFactory(viewModelFactory: appViewModelFactory)
    }
}


protocol ViewFactory {
    func jokesView() -> JokesView
}

final class AppViewFactory: ViewFactory {

    let viewModelFactory: ViewModelFactory

    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }

    func jokesView() -> JokesView {
        JokesView(viewModel: viewModelFactory.jokesViewViewModel())
    }
}

import JokesView
import ViewModel

protocol ViewModelFactory {
    func jokesViewViewModel() -> JokesViewViewModel
}
final class AppViewModelFactory: ViewModelFactory {
    func jokesViewViewModel() -> JokesViewViewModel {
        AppJokesViewViewModel()
    }
}

final class AppJokesViewViewModel: JokesViewViewModel {
    var state: ViewModelState<JokesViewState>

    init() {
        state = ViewModelState(initialState: JokesViewState(joke: "", punchline: nil))
    }
}
