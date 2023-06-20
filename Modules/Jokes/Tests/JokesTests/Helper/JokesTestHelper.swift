import Foundation

@testable import Jokes

final class JokesTestHelper {
    static func createJokeDto(
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

    static func createJoke(
        id: Int = 1,
        category: JokeCategory = .any,
        details: JokeDetails = .single(joke: "The joke")
    ) -> Joke {
        Joke(id: id, category: category, details: details)
    }
}
