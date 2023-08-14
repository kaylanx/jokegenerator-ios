import SwiftUI

import JokesView

struct ContentView: View {

    let jokeViewFactory: () -> JokesView

    var body: some View {
        VStack {
            jokeViewFactory()
        }
        .padding()
    }
}

#Preview {
    ContentView {
        JokesView(viewModel: PreviewJokesViewViewModel(joke: "Jokes", punchline: "Lol", showPunchline: true, showPunchlineButtonVisible: true))
    }
}
