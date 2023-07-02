import SwiftUI

import ViewModel

public struct JokesViewState {
    public var joke: String
    public var punchline: String?
    public var showPunchline: Bool
    public var showPunchlineButtonVisible: Bool

    public init(
        joke: String,
        punchline: String?,
        showPunchline: Bool,
        showPunchlineButtonVisible: Bool
    ) {
        self.joke = joke
        self.punchline = punchline
        self.showPunchline = showPunchline
        self.showPunchlineButtonVisible = showPunchlineButtonVisible
    }
}

public protocol JokesViewViewModel {
    var state: ViewModelState<JokesViewState> { get }

    func getNewJoke() async
    func showPunchlineTapped()
}

public struct JokesView: View {

    private let viewModel: JokesViewViewModel

    public init(viewModel: JokesViewViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(viewModel.state.joke)
            punchline
            showPunchlineButton
            getNewJokeButton
        }
        .task {
            await viewModel.getNewJoke()
        }
    }

    @ViewBuilder
    private var punchline: some View {
        if let punchline = viewModel.state.punchline, viewModel.state.showPunchline {
            Text(punchline)
        }
    }

    private var getNewJokeButton: some View {
        Button {
            Task {
                await viewModel.getNewJoke()
            }
        } label: {
            Text("Get another joke")
        }
    }

    @ViewBuilder
    private var showPunchlineButton: some View {
        if viewModel.state.showPunchlineButtonVisible {
            Button(action: viewModel.showPunchlineTapped) {
                Text("Reveal punchline")
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
        state = ViewModelState(
            initialState:
                JokesViewState(
                    joke: joke,
                    punchline: punchline,
                    showPunchline: true,
                    showPunchlineButtonVisible: true
                )
        )
    }

    public func getNewJoke() {
    }

    public func showPunchlineTapped() {
    }
}
