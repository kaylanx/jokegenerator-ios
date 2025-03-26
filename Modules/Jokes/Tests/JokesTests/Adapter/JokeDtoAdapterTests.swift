import Testing

@testable import Jokes

struct JokeDtoAdapterTests {

    let adapter = JokeDtoAdapter()

    @Test func singleJokeAdaptedCorrectly() throws {

        let jokeDto = JokesTestHelper.createJokeDto(
            id: 11,
            category: "Programming",
            type: "single",
            joke: "The joke"
        )

        let joke = try adapter.adapt(jokeDto: jokeDto)

        #expect(joke.id == 11)
        #expect(joke.category == .programming)
        #expect(joke.details == .single(joke: "The joke"))
    }

    @Test func twoPartJokeAdaptedCorrectly() throws {

        let jokeDto = JokesTestHelper.createJokeDto(
            id: 13,
            category: "Programming",
            type: "twopart",
            setup: "The setup",
            delivery: "The punchline"
        )

        let joke = try adapter.adapt(jokeDto: jokeDto)

        #expect(joke.id == 13)
        #expect(joke.category == .programming)
        #expect(joke.details == .twopart(setup: "The setup", delivery: "The punchline"))
    }

    @Test func idMissingThrowsError() throws {

        let jokeDto = JokesTestHelper.createJokeDto()

        #expect(throws: JokeDtoAdapterError.idNull) {
            try adapter.adapt(jokeDto: jokeDto)
        }
    }

    @Test func invalidTypeThrowsError() throws {
        let jokeDto = JokesTestHelper.createJokeDto(
            id: 1,
            category: "Programming",
            type: "Doesn't Exist"
        )

        #expect(throws: JokeDtoAdapterError.invalidType("Doesn't Exist is invalid")) {
            try adapter.adapt(jokeDto: jokeDto)
        }
    }

    @Test func invalidCategoryThrowsError() throws {
        let jokeDto = JokesTestHelper.createJokeDto(
            id: 1,
            category: "Doesn't Exist",
            type: "single"
        )

        #expect(throws: JokeDtoAdapterError.invalidCategory("Doesn't Exist is invalid")) {
            try adapter.adapt(jokeDto: jokeDto)
        }
    }

    @Test(
        "Categories Are Adapted Correctly",
        arguments: zip([
            "Any",
            "Misc",
            "Programming",
            "Dark",
            "Pun",
            "Spooky",
            "Christmas"
        ], JokeCategory.allCases)
    )
    func categoryAdaptedCorrectly(categoryString: String, jokeCategory: JokeCategory) async throws {
        let jokeDto = JokesTestHelper.createJokeDto(
            id: 1,
            category: categoryString,
            type: "single"
        )

        let joke = try adapter.adapt(jokeDto: jokeDto)

        #expect(joke.category == jokeCategory)
    }
}

extension JokeDetails: Equatable {
    public static func == (lhs: JokeDetails, rhs: JokeDetails) -> Bool {
        return switch (lhs, rhs) {
        case (.single(let lhsJoke), .single(let rhsJoke)):
            lhsJoke == rhsJoke
        case (.twopart(let lhsSetup, let lhsDelivery), .twopart(let rhsSetup, let rhsDelivery)):
            lhsSetup == rhsSetup && lhsDelivery == rhsDelivery
        default: false
        }
    }
}

extension JokeDtoAdapterError: Equatable {
    public static func == (lhs: JokeDtoAdapterError, rhs: JokeDtoAdapterError) -> Bool {
        return switch (lhs, rhs) {
        case (.idNull, .idNull): true
        case (.invalidType(let lhsErrorMessage), .invalidType(let rhsErrorMessage)):
            lhsErrorMessage == rhsErrorMessage
        case (.invalidCategory(let lhsErrorMessage), .invalidCategory(let rhsErrorMessage)):
            lhsErrorMessage == rhsErrorMessage
        default: false
        }
    }
}
