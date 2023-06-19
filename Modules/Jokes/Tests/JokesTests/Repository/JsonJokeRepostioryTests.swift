import XCTest

import RequestMaker

@testable import RequestMakerTestHelper
@testable import Jokes

final class JsonJokeRepositoryTests: XCTestCase {

    private var networkJokeRepository: JokeRepository!
    private var stubRequestMaker = StubRequestMaker()

    override func setUpWithError() throws {
        try super.setUpWithError()
        networkJokeRepository = JsonJokeRepository(requestMaker: stubRequestMaker)
    }

    func testTwoPartJokeReturnedCorrectly() async throws {

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

        XCTAssertEqual(false, joke.error)
        XCTAssertEqual("Programming", joke.category)
        XCTAssertEqual("twopart", joke.type)
        XCTAssertNil(joke.joke)
        XCTAssertEqual("Why do they call it hyper terminal?", joke.setup)
        XCTAssertEqual("Too much Java.", joke.delivery)
        XCTAssertEqual(false, joke.flags?.nsfw)
        XCTAssertEqual(false, joke.flags?.religious)
        XCTAssertEqual(false, joke.flags?.racist)
        XCTAssertEqual(false, joke.flags?.sexist)
        XCTAssertEqual(false, joke.flags?.explicit)

        XCTAssertEqual(226, joke.id)
        XCTAssertEqual(true, joke.safe)
        XCTAssertEqual("en", joke.lang)
    }

    func testSingleJokeReturnedCorrectly() async throws {

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

        XCTAssertEqual(false, joke.error)
        XCTAssertEqual("Programming", joke.category)
        XCTAssertEqual("single", joke.type)
        XCTAssertEqual("Programming is 10% science, 20% ingenuity, and 70% getting the ingenuity to work with the science.", joke.joke)
        XCTAssertNil(joke.setup)
        XCTAssertNil(joke.delivery)
        XCTAssertEqual(false, joke.flags?.nsfw)
        XCTAssertEqual(false, joke.flags?.religious)
        XCTAssertEqual(false, joke.flags?.racist)
        XCTAssertEqual(false, joke.flags?.sexist)
        XCTAssertEqual(false, joke.flags?.explicit)

        XCTAssertEqual(37, joke.id)
        XCTAssertEqual(true, joke.safe)
        XCTAssertEqual("en", joke.lang)
    }

    func testErrorJsonThrowsClientError() async throws {

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

        let expectation = expectation(description: "JokeRepositoryError.client should be thrown")
        do {
            let _ = try await networkJokeRepository.joke(for: .any)
        } catch JokeRepositoryError.client(let errorDetails) {
            XCTAssertEqual(106, errorDetails.code)
            XCTAssertEqual("No matching joke found", errorDetails.message)
            XCTAssertEqual(["No jokes were found that match your provided filter(s)"], errorDetails.causedBy)
            XCTAssertEqual("The specified category is invalid - Got: \"foo\" - Possible categories are: \"Any, Misc, Programming, Dark, Pun, Spooky, Christmas\" (case insensitive)", errorDetails.additionalInfo)
            XCTAssertEqual(1579170794412, errorDetails.timestamp)
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 0.1)
    }

    func testErrorJsonThrowsInternalError() async throws {

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

        let expectation = expectation(description: "JokeRepositoryError.client internal be thrown")
        do {
            let _ = try await networkJokeRepository.joke(for: .any)
        } catch JokeRepositoryError.internal(let errorDetails) {
            XCTAssertEqual(777, errorDetails.code)
            XCTAssertEqual("Something went terribly wrong", errorDetails.message)
            XCTAssertEqual(["Servers are on fire"], errorDetails.causedBy)
            XCTAssertEqual("Internal server error", errorDetails.additionalInfo)
            XCTAssertEqual(1579170794412, errorDetails.timestamp)
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 0.1)
    }
}
