import Observation
import JokesView
import Jokes

@Observable
final class AppJokesViewViewModel: JokesViewViewModel {

    var joke: String = ""
    var punchline: String? = nil
    var showPunchline: Bool = false
    var showPunchlineButtonVisible: Bool = false

    private let jokeService: JokeService

    init(jokeService: JokeService) {
        self.jokeService = jokeService
    }

    func getNewJoke() async {
        if let joke = try? await jokeService.joke(for: .any) {
            await MainActor.run { [weak self] in
                guard let self else { return }
                showPunchline = false
                switch joke.details {
                case .single(let joke):
                    self.joke = joke
                    punchline = nil
                case .twopart(let setup, let delivery):
                    self.joke = setup
                    punchline = delivery
                }
                showPunchlineButtonVisible = punchline != nil
            }
        }
    }

    @MainActor
    func showPunchlineTapped() {
        if punchline != nil {
            showPunchline = true
            showPunchlineButtonVisible = false
        }
    }
}
