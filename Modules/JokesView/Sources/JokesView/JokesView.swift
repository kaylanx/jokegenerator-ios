import SwiftUI

public protocol JokesViewViewModel {
    var joke: String { get }
    var punchline: String? { get }
    var showPunchline: Bool { get }
    var showPunchlineButtonVisible: Bool { get }

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
            Text(viewModel.joke)
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
        if let punchline = viewModel.punchline, viewModel.showPunchline {
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
        if viewModel.showPunchlineButtonVisible {
            Button(action: viewModel.showPunchlineTapped) {
                Text("Reveal punchline")
            }
        }
    }
}

#Preview("Single joke") {
    JokesView(viewModel: PreviewJokeViewViewModel.singleJoke)
}

#Preview("Punchline hidden") {
    JokesView(viewModel: PreviewJokeViewViewModel.jokeWithPunchlineWithPunchlineHidden)
}

#Preview("Punchline visible") {
    JokesView(viewModel: PreviewJokeViewViewModel.jokeWithPunchlineWithPunchlineVisible)
}

private final class PreviewJokeViewViewModel: JokesViewViewModel {

    static let singleJoke = PreviewJokeViewViewModel(joke: "A joke", punchline: nil, showPunchline: false, showPunchlineButtonVisible: false)
    static let jokeWithPunchlineWithPunchlineHidden = PreviewJokeViewViewModel(joke: "Another joke", punchline: "With a punchline", showPunchline: false, showPunchlineButtonVisible: true)
    static let jokeWithPunchlineWithPunchlineVisible = PreviewJokeViewViewModel(joke: "Yet another joke", punchline: "With a punchline", showPunchline: true, showPunchlineButtonVisible: false)

    var joke: String
    var punchline: String?
    var showPunchline: Bool
    var showPunchlineButtonVisible: Bool

    init(
        joke: String,
        punchline: String? = nil,
        showPunchline: Bool,
        showPunchlineButtonVisible: Bool
    ) {
        self.joke = joke
        self.punchline = punchline
        self.showPunchline = showPunchline
        self.showPunchlineButtonVisible = showPunchlineButtonVisible
    }

    public func getNewJoke() {
    }

    public func showPunchlineTapped() {
    }
}
