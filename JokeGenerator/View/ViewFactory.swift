import JokesView

protocol ViewFactory {
    func jokesView() -> JokesView
}

final class AppViewFactory: ViewFactory {

    let viewModelFactory: ViewModelFactory

    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }

    func jokesView() -> JokesView {
        JokesView(viewModel: viewModelFactory.jokesViewViewModel())
    }
}
