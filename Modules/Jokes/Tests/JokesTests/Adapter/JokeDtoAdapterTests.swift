import XCTest

@testable import Jokes

final class JokeDtoAdapterTests: XCTestCase {

    let adapter = JokeDtoAdapter()

    func testSingleJokeAdaptedCorrectly() throws {

        let jokeDto = createDto(
            id: 11,
            category: "Programming",
            type: "single",
            joke: "The joke"
        )

        let joke = try adapter.adapt(jokeDto: jokeDto)

        XCTAssertEqual(11, joke.id)

        XCTAssertEqual(JokeCategory.programming, joke.category)

        switch joke.details {
        case .single(joke: let joke):
            XCTAssertEqual("The joke", joke)
        case .twopart:
            XCTFail("Joke details should be single")
        }
    }

    func testTwoPartJokeAdaptedCorrectly() throws {

        let jokeDto = createDto(
            id: 13,
            category: "Programming",
            type: "twopart",
            setup: "The setup",
            delivery: "The punchline"
        )

        let joke = try adapter.adapt(jokeDto: jokeDto)

        XCTAssertEqual(13, joke.id)

        XCTAssertEqual(JokeCategory.programming, joke.category)

        switch joke.details {
        case .single:
            XCTFail("Joke details should be twoaprt")
        case .twopart(let setup, let delivery):
            XCTAssertEqual("The setup", setup)
            XCTAssertEqual("The punchline", delivery)
        }
    }

    func testIdMissingThrowsError() throws {
        let jokeDto = createDto()
        let expectation = expectation(description: "idNull Should Be thrown")
        do {
            let _ = try adapter.adapt(jokeDto: jokeDto)
        } catch JokeDtoAdapterError.idNull {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testInvalidTypeThrowsError() throws {
        let jokeDto = createDto(
            id: 1,
            category: "Programming",
            type: "Doesn't Exist"
        )
        let expectation = expectation(description: "Invalid Type Should Be thrown")
        do {
            let _ = try adapter.adapt(jokeDto: jokeDto)
        } catch JokeDtoAdapterError.invalidType(let invalidTypeMessage) {
            XCTAssertEqual("Doesn't Exist is invalid", invalidTypeMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testEachCategoryAdaptedCorrectly() throws {
        try assertEqual(categoryString: "Programming", jokeCategory: .programming)
        try assertEqual(categoryString: "Any", jokeCategory: .any)
        try assertEqual(categoryString: "Christmas", jokeCategory: .christmas)
        try assertEqual(categoryString: "Dark", jokeCategory: .dark)
        try assertEqual(categoryString: "Misc", jokeCategory: .misc)
        try assertEqual(categoryString: "Pun", jokeCategory: .pun)
        try assertEqual(categoryString: "Spooky", jokeCategory: .spooky)

        let expectation = expectation(description: "Invalid Category Should Be thrown")
        do {
            try assertEqual(categoryString: "Doesn't Exist", jokeCategory: .spooky)
        } catch JokeDtoAdapterError.invalidCategory(let invalidCategoryMessage) {
            XCTAssertEqual("Doesn't Exist is invalid", invalidCategoryMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    private func assertEqual(categoryString: String, jokeCategory: JokeCategory) throws {
        let jokeDto = createDto(
            id: 1,
            category: categoryString,
            type: "single"
        )

        let joke = try adapter.adapt(jokeDto: jokeDto)

        XCTAssertEqual(jokeCategory, joke.category)
    }

    private func createDto(
        id: Int? = nil,
        category: String? = nil,
        type: String? = nil,
        joke: String? = nil,
        setup: String? = nil,
        delivery: String? = nil,
        nsfw: Bool? = nil,
        religious: Bool? = nil,
        political: Bool? = nil,
        racist: Bool? = nil,
        sexist: Bool? = nil,
        explicit: Bool? = nil,
        safe: Bool? = nil,
        lang: String? = nil,
        error: Bool? = nil,
        internalError: Bool? = nil,
        code: Int? = nil,
        message: String? = nil,
        causedBy: [String]? = nil,
        additionalInfo: String? = nil,
        timestamp: Int? = nil
    ) -> JokeDto {
        JokeDto(
            id: id,
            category: category,
            type: type,
            joke: joke,
            setup: setup,
            delivery: delivery,
            flags: JokeDto.Flags(
                nsfw: nsfw,
                religious: religious,
                political: political,
                racist: racist,
                sexist: sexist,
                explicit: explicit
            ),
            safe: safe,
            lang: lang,
            error: error,
            internalError: internalError,
            code: code,
            message: message,
            causedBy: causedBy,
            additionalInfo: additionalInfo,
            timestamp: timestamp
        )
    }
}
