import SwiftUI

@main
struct JokeGeneratorApp: App {

    private let appContainer = AppContainer()

    var body: some Scene {
        WindowGroup {
            ContentView(jokeViewFactory: appContainer.appViewFactory.jokesView)
        }
    }
}

