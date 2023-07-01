import JokesView
import Jokes
import ViewModel

final class AppJokesViewViewModel: JokesViewViewModel {

    var state: ViewModelState<JokesViewState>
    private let jokeService: JokeService

    init(jokeService: JokeService) {
        state = ViewModelState(initialState: JokesViewState(joke: "", punchline: nil))
        self.jokeService = jokeService
    }

    func getNewJoke() async {
        if let joke = try? await jokeService.joke(for: .any) {
            await MainActor.run {
                state.update { state in
                    switch joke.details {
                    case .single(joke: let joke):
                        state.joke = joke
                    case .twopart(setup: let setup, delivery: let delivery):
                        state.joke = setup
                        state.punchline = delivery
                    }
                }
            }
        }
    }
}
