import XCTest

@testable import Jokes

final class JokeDtoAdapterTests: XCTestCase {

    func textSingleJokeAdaptedCorrectly() throws {

        let jokeDto = createDto(
            id: 11,
            category: "Programming",
            type: "single",
            joke: "The joke",
            safe: true,
            lang: "en",
            error: false
        )

        let adapter = JokeDtoAdapter()

        let joke = try adapter.adapt(jokeDto: jokeDto)

        XCTAssertEqual(11, joke.id)

        guard case .programming = joke.category else {
            XCTFail("Joke category should be programming")
            return
        }

        switch joke.details {
        case .single(joke: let joke):
            XCTAssertEqual("The joke", joke)
        case .twopart:
            XCTFail("Joke details should be single")
        }
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
