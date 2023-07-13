# JokesView

The **JokesView** package provides a SwiftUI view for displaying jokes. It includes a view model protocol, a view struct, and a preview provider for testing.

## Usage

### Importing

To use the **JokesView** package in your code, import it as follows:

```swift
import JokesView
```

### JokesViewViewModel

The `JokesViewViewModel` protocol defines the view model interface for the **JokesView**. It includes the following properties and methods:

Properties:
- `joke`: The current joke text.
- `punchline`: The punchline of the joke (optional).
- `showPunchline`: A boolean value indicating whether the punchline should be shown.
- `showPunchlineButtonVisible`: A boolean value indicating whether the punchline reveal button should be visible.

Methods:
- `getNewJoke() async`: Fetches a new joke asynchronously.
- `showPunchlineTapped()`: Handles the action when the punchline reveal button is tapped.

### JokesView

The `JokesView` struct represents a SwiftUI view for displaying jokes. It takes a view model conforming to the `JokesViewViewModel` protocol as its initialization parameter.

To use the `JokesView` in your SwiftUI hierarchy, create an instance of the view and provide the appropriate view model.

```swift
let viewModel = MyJokesViewViewModel()
let jokesView = JokesView(viewModel: viewModel)
```

The `JokesView` consists of a vertical stack (`VStack`) containing the following components:
- `Text` view displaying the current joke.
- Optional `Text` view displaying the punchline.
- Button to reveal the punchline (if visible).
- Button to get a new joke.

The view automatically fetches a new joke using the view model's `getNewJoke()` method when the view appears.
