# JokeGenerator Xcode Project

![Swift Version](https://img.shields.io/badge/swift-5.9-orange.svg)
![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

JokeGenerator is a Swift-based Xcode project that demonstrates the usage of the JokeAPI by utilizing a local Jokes package. The Jokes package is dependent on the RequestMaker package to handle API requests. The user interface is provided by the JokesView package, offering a seamless experience for displaying jokes fetched from the JokeAPI.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Features

- Fetches jokes from the JokeAPI using the local Jokes package.
- Utilizes the RequestMaker package to handle API requests.
- Displays jokes in an elegant user interface provided by the JokesView package.
- Simple and easy-to-understand codebase, ideal for learning Swift app architecture.

## Requirements

- Xcode 15.0+
- Swift 5.9+
- iOS 17.0+ 

## Installation

1. Clone or download the JokeGenerator project repository.
2. Open the project in Xcode.
3. The project should automatically resolve package dependencies. If not, ensure you have an active internet connection and allow Xcode to fetch the necessary packages.

## Usage

1. Open the JokeGenerator project in Xcode.
2. Explore the project structure, which includes the Jokes, RequestMaker, and JokesView packages, along with the main app target.
3. Configure the target platform and simulator/device to run the app.
4. Build and run the project in Xcode.
5. The app will display a joke fetched from the JokeAPI using the Jokes package and displayed using the JokesView package.

## Contributing

Contributions are welcome! If you find any issues or want to enhance the project, feel free to open a pull request. Please ensure to follow the existing code style and provide clear commit messages.

1. Fork the repository.
2. Create a new branch for your feature or bug fix: `git checkout -b feature/your-feature-name` or `bugfix/issue-number`.
3. Commit your changes with descriptive commit messages.
4. Push your branch to your forked repository.
5. Open a pull request to the main repository's `main` branch.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
