# RequestMaker

The **RequestMaker** package provides functionality for making network requests. It includes protocols for request makers and a factory class for creating request makers.

## Usage

### Importing

To use the **RequestMaker** package in your code, import it as follows:

```swift
import RequestMaker
```

### RequestMaker

The `RequestMaker` protocol defines the interface for making network requests. It includes the following method:

```swift
func makeRequest(for url: URL) async throws -> Data
```

Implement this protocol to create your own request maker that can make requests for a given URL. The method makes an asynchronous request and returns the resulting data or throws an error.

### RequestMakerFactory

The `RequestMakerFactory` protocol defines the interface for creating request makers. It includes the following method:

```swift
func requestMaker() -> RequestMaker
```

Implement this protocol to provide a factory that creates instances of request makers. The `requestMaker()` method returns a `RequestMaker` object.

### AppRequestMakerFactory

The `AppRequestMakerFactory` class is an implementation of the `RequestMakerFactory` protocol. It creates instances of the `NetworkRequestMaker` class, which is a concrete implementation of the `RequestMaker` protocol.

To use the `AppRequestMakerFactory`, create an instance of it and call the `requestMaker()` method.

```swift
let requestMakerFactory = AppRequestMakerFactory()
let requestMaker = requestMakerFactory.requestMaker()
```

The `AppRequestMakerFactory` can be customized or extended to create request makers specific to your application's needs.
