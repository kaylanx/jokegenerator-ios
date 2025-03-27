import Testing

import RequestMaker

@testable import RequestMakerTestHelper
@testable import Jokes

struct JsonJokeRepositoryTests {

    private let networkJokeRepository: JokeRepository
    private let stubRequestMaker = StubRequestMaker()

    init() {
        networkJokeRepository = JsonJokeRepository(requestMaker: stubRequestMaker)
    }

    @Test
    func twoPartJokeReturnedCorrectly() async throws {

        stubRequestMaker.dataToReturn = """
        {
            "error": false,
            "category": "Programming",
            "type": "twopart",
            "setup": "Why do they call it hyper terminal?",
            "delivery": "Too much Java.",
            "flags": {
                "nsfw": false,
                "religious": false,
                "political": false,
                "racist": false,
                "sexist": false,
                "explicit": false
            },
            "id": 226,
            "safe": true,
            "lang": "en"
        }
        """.data(using: .utf8)

        let joke = try await networkJokeRepository.joke(for: .any)

        #expect(joke.error == false)

        #expect(joke.category == "Programming")
        #expect(joke.type == "twopart")
        #expect(joke.joke == nil)
        #expect(joke.setup == "Why do they call it hyper terminal?")
        #expect(joke.delivery == "Too much Java.")
        #expect(joke.flags?.nsfw == false)
        #expect(joke.flags?.religious == false)
        #expect(joke.flags?.racist == false)
        #expect(joke.flags?.sexist == false)
        #expect(joke.flags?.explicit == false)

        #expect(joke.id == 226)
        #expect(joke.safe == true)
        #expect(joke.lang == "en")
    }

    @Test
    func singleJokeReturnedCorrectly() async throws {

        stubRequestMaker.dataToReturn = """
        {
            "error": false,
            "category": "Programming",
            "type": "single",
            "joke": "Programming is 10% science, 20% ingenuity, and 70% getting the ingenuity to work with the science.",
            "flags": {
                "nsfw": false,
                "religious": false,
                "political": false,
                "racist": false,
                "sexist": false,
                "explicit": false
            },
            "id": 37,
            "safe": true,
            "lang": "en"
        }
        """.data(using: .utf8)

        let joke = try await networkJokeRepository.joke(for: .any)

        #expect(joke.error == false)
        #expect(joke.category == "Programming")
        #expect(joke.type == "single")
        #expect(joke.joke == "Programming is 10% science, 20% ingenuity, and 70% getting the ingenuity to work with the science.")
        #expect(joke.setup == nil)
        #expect(joke.delivery == nil)
        #expect(joke.flags?.nsfw == false)
        #expect(joke.flags?.religious == false)
        #expect(joke.flags?.racist == false)
        #expect(joke.flags?.sexist == false)
        #expect(joke.flags?.explicit == false)

        #expect(joke.id == 37)
        #expect(joke.safe == true)
        #expect(joke.lang == "en")
    }

    @Test
    func errorJsonThrowsClientError() async throws {

        stubRequestMaker.dataToReturn = """
        {
            "error": true,
            "internalError": false,
            "code": 106,
            "message": "No matching joke found",
            "causedBy": [
                "No jokes were found that match your provided filter(s)"
            ],
            "additionalInfo": "The specified category is invalid - Got: \\"foo\\" - Possible categories are: \\"Any, Misc, Programming, Dark, Pun, Spooky, Christmas\\" (case insensitive)",
            "timestamp": 1579170794412
        }
        """.data(using: .utf8)


        let errorDetails = JokeRepositoryError.JokeErrorDetails(
            code: 106,
            message: "No matching joke found",
            causedBy: ["No jokes were found that match your provided filter(s)"],
            additionalInfo: "The specified category is invalid - Got: \"foo\" - Possible categories are: \"Any, Misc, Programming, Dark, Pun, Spooky, Christmas\" (case insensitive)",
            timestamp: 1579170794412
        )
        await #expect(throws: JokeRepositoryError.client(errorDetails)) {
             try await networkJokeRepository.joke(for: .any)
        }
    }

    @Test
    func errorJsonThrowsInternalError() async throws {

        stubRequestMaker.dataToReturn = """
        {
            "error": true,
            "internalError": true,
            "code": 777,
            "message": "Something went terribly wrong",
            "causedBy": [
                "Servers are on fire"
            ],
            "additionalInfo": "Internal server error",
            "timestamp": 1579170794412
        }
        """.data(using: .utf8)

        let errorDetails = JokeRepositoryError.JokeErrorDetails(
            code: 777,
            message: "Something went terribly wrong",
            causedBy: ["Servers are on fire"],
            additionalInfo: "Internal server error",
            timestamp: 1579170794412
        )
        await #expect(throws: JokeRepositoryError.internal(errorDetails)) {
            try await networkJokeRepository.joke(for: .any)
        }
    }
}

extension JokeRepositoryError: Equatable {
    public static func == (lhs: JokeRepositoryError, rhs: JokeRepositoryError) -> Bool {
        return switch (lhs, rhs) {
        case (.internal(let lhsJokeDetails), .internal(let rhsJokeDetails)):
            lhsJokeDetails == rhsJokeDetails
        case (.client(let lhsJokeDetails), .client(let rhsJokeDetails)):
            lhsJokeDetails == rhsJokeDetails
        default: false
        }
    }
}

extension JokeRepositoryError.JokeErrorDetails: Equatable {
    public static func == (lhs: JokeRepositoryError.JokeErrorDetails, rhs: JokeRepositoryError.JokeErrorDetails) -> Bool {
        lhs.message == rhs.message &&
        lhs.code == rhs.code &&
        lhs.causedBy == rhs.causedBy &&
        lhs.additionalInfo == rhs.additionalInfo &&
        lhs.timestamp == rhs.timestamp
    }
}
