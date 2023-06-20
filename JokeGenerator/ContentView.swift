import SwiftUI

import JokesView

struct ContentView: View {

    let jokeViewFactory: () -> JokesView

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            jokeViewFactory()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView {
            JokesView(viewModel: PreviewJokeViewViewModel(joke: "Jokes", punchline: "Lol"))
        }
    }
}
