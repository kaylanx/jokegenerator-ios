import Foundation
import ViewModel
import Jokes
import JokesView

protocol ViewModelFactory {
    func jokesViewViewModel() -> JokesViewViewModel
}

final class AppViewModelFactory: ViewModelFactory {

    let jokeServiceContainer: JokeServiceContainer
    init(jokeServiceContainer: JokeServiceContainer) {
        self.jokeServiceContainer = jokeServiceContainer
    }

    func jokesViewViewModel() -> JokesViewViewModel {
        AppJokesViewViewModel(jokeService: jokeServiceContainer.jokeService)
    }
}
