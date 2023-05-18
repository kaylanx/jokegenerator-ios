//
//  JsonJokeRepositoryTests.swift
//
//  Created by Andy Kayley on 17/05/2023.
//

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

        stubRequestMaker.jsonJokeToReturn = """
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
        """

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

        stubRequestMaker.jsonJokeToReturn = """
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
        """

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
}
