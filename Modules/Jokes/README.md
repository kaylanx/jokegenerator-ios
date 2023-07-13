# Jokes

The **Jokes** package provides functionality to fetch jokes of different categories. It includes definitions for joke categories, joke details, joke objects, error handling, and a service interface to retrieve jokes.

## Usage

### Importing

To use the **Jokes** package in your code, import it as follows:

```swift
import Jokes
```

### Joke Categories

The `JokeCategory` enum defines different categories of jokes. It includes the following cases:

- `any`: Represents any category of jokes.
- `misc`: Represents miscellaneous jokes.
- `programming`: Represents programming-related jokes.
- `dark`: Represents dark humor jokes.
- `pun`: Represents pun jokes.
- `spooky`: Represents spooky jokes.
- `christmas`: Represents Christmas-themed jokes.

You can convert a string to a `JokeCategory` using the `from(string:)` method.

```swift
let category = JokeCategory.from(string: "Programming")
```

### Joke Details

The `JokeDetails` enum represents the details of a joke. It can either be a single-line joke or a two-part joke with a setup and delivery.

- `single(joke: String)`: Represents a single-line joke.
- `twopart(setup: String, delivery: String)`: Represents a two-part joke with a setup and delivery.

### Joke

The `Joke` struct represents a joke object. It contains the following properties:

- `id`: The unique identifier of the joke.
- `category`: The category of the joke (`JokeCategory`).
- `details`: The details of the joke (`JokeDetails`).

### Joke Service

The `JokeService` protocol defines a service interface for retrieving jokes. It includes the following method:

```swift
func joke(for category: JokeCategory) async throws -> Joke
```

You can implement this protocol to provide your own joke service. The method retrieves a joke for the specified category asynchronously and throws a `JokeServiceError` if an error occurs.

### Joke Service Container

The `JokeServiceContainer` class acts as a container for the `JokeService`. It provides a convenient way to initialize the `JokeService` with the required dependencies.

To create an instance of `JokeServiceContainer`, you need to provide a `RequestMakerFactory` object during initialization. The `RequestMakerFactory` is from the **RequestMaker** package, which you must also import.

```swift
import RequestMaker

let requestMakerFactory = RequestMakerFactory()
let jokeServiceContainer = JokeServiceContainer(requestMakerFactory: requestMakerFactory)
```

The `JokeServiceContainer` initializes the `JokeService` using a `JokeRepository` and a `JokeDtoAdapter`. These dependencies are managed by the `JokeRepositoryContainer`, which is also contained within the `JokeServiceContainer`.

## Error Handling

The `JokeService` protocol throws a `JokeServiceError` if an error occurs during the retrieval of jokes. The `JokeServiceError` is an enum with the following cases:

- `internal`: Indicates an internal error occurred in the joke service.
- `client`: Indicates an error occurred due to client-related issues.

Handle these errors accordingly in your code.
