import SwiftUI

import ViewModel

public struct JokesViewState {
    public let joke: String
    public let punchline: String?

    public init(joke: String, punchline: String?) {
        self.joke = joke
        self.punchline = punchline
    }
}

public protocol JokesViewViewModel {
    var state: ViewModelState<JokesViewState> { get }
}

public struct JokesView: View {

    @ObservedObject private var state: ViewModelState<JokesViewState>
    private let viewModel: JokesViewViewModel

    public init(viewModel: JokesViewViewModel) {
        self.viewModel = viewModel
        self.state = viewModel.state
    }

    public var body: some View {
        VStack {
            Text(state.joke)
            if let punchline = state.punchline {
                Text(punchline)
            }
        }
    }
}

struct JokesView_Previews: PreviewProvider {
    static var previews: some View {
        JokesView(viewModel: PreviewJokeViewViewModel(joke: "A joke", punchline: nil))
        JokesView(viewModel: PreviewJokeViewViewModel(joke: "Another joke", punchline: "With a punchline"))
    }
}

public final class PreviewJokeViewViewModel: JokesViewViewModel {
    public var state: ViewModelState<JokesViewState>

    public init(joke: String, punchline: String?) {
        state = ViewModelState(initialState: JokesViewState(joke: joke, punchline: punchline))
    }
}
