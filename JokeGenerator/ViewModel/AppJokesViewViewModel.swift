import JokesView
import Jokes
import ViewModel

final class AppJokesViewViewModel: JokesViewViewModel {

    var state: ViewModelState<JokesViewState>
    private let jokeService: JokeService

    init(jokeService: JokeService) {
        state = ViewModelState(
            initialState:
                JokesViewState(
                    joke: "",
                    punchline: nil,
                    showPunchline: false,
                    showPunchlineButtonVisible: false
                )
        )
        self.jokeService = jokeService
    }

    func getNewJoke() async {
        if let joke = try? await jokeService.joke(for: .any) {
            await MainActor.run {
                state.update { state in
                    state.showPunchline = false
                    switch joke.details {
                    case .single(joke: let joke):
                        state.joke = joke
                        state.punchline = nil
                    case .twopart(setup: let setup, delivery: let delivery):
                        state.joke = setup
                        state.punchline = delivery
                    }
                    state.showPunchlineButtonVisible = state.punchline != nil
                }
            }
        }
    }

    @MainActor
    func showPunchlineTapped() {
        if state.punchline != nil {
            state.update { state in
                state.showPunchline = true
                state.showPunchlineButtonVisible = false
            }
        }
    }
}
