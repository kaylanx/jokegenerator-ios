import JokesView

final class PreviewJokesViewViewModel: JokesViewViewModel {
    var joke: String
    var punchline: String?
    var showPunchline: Bool
    var showPunchlineButtonVisible: Bool

    init(joke: String, punchline: String? = nil, showPunchline: Bool, showPunchlineButtonVisible: Bool) {
        self.joke = joke
        self.punchline = punchline
        self.showPunchline = showPunchline
        self.showPunchlineButtonVisible = showPunchlineButtonVisible
    }

    func getNewJoke() async {
    }
    
    func showPunchlineTapped() {
    }
}
