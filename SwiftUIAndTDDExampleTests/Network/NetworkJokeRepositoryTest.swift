//
//  NetworkJokeRepository.swift
//  SwiftUIAndTDDExampleTests
//
//  Created by Andy Kayley on 17/05/2023.
//

import XCTest

enum NetworkJokeCategory: String {
    case any
}

struct NetworkJoke: Decodable {
    let id: Int?
    let error: Bool?
    let category: String?
    let type: String?
    let setup: String?
    let delivery: String?
    let flags: Flags?
    let safe: Bool?
    let lang: String?

    struct Flags: Decodable {
        let nsfw: Bool?
        let religious: Bool?
        let political: Bool?
        let racist: Bool?
        let sexist: Bool?
        let explicit: Bool?
    }
}

protocol JokeRepository {
    func joke(for category: NetworkJokeCategory) async throws -> NetworkJoke
}

protocol RequestMaker {
    func makeRequest(for url: String) async throws -> Data
}

final class StubRequestMaker: RequestMaker {
    var jsonJokeToReturn: String = "{ }"
    var errorToThrow: Error?

    var makeRequestCalled: Bool = false
    func makeRequest(for url: String) async throws -> Data {
        makeRequestCalled = true

        if let errorToThrow {
            throw errorToThrow
        }
        return jsonJokeToReturn.data(using: .utf8)!
    }
}

final class NetworkJokeRepository: JokeRepository {

    let requestMaker: RequestMaker

    init(requestMaker: RequestMaker) {
        self.requestMaker = requestMaker
    }

    func joke(for category: NetworkJokeCategory) async throws -> NetworkJoke {
        let jsonData = try await requestMaker.makeRequest(for: "https://v2.jokeapi.dev/joke/\(category)")
        return try JSONDecoder().decode(NetworkJoke.self, from: jsonData)
    }
}

final class NetworkJokeRepositoryTest: XCTestCase {

    private var networkJokeRepository: JokeRepository!
    private var stubRequestMaker = StubRequestMaker()

    override func setUpWithError() throws {
        try super.setUpWithError()
        networkJokeRepository = NetworkJokeRepository(requestMaker: stubRequestMaker)
    }

    func testTwoPartJokeReturnedCorrectly() async throws {

        stubRequestMaker.jsonJokeToReturn = """
        {
            "error": false,
            "category": "Misc",
            "type": "twopart",
            "setup": "My wife left me because I'm too insecure and paranoid.",
            "delivery": "Oh wait, never mind. She was just getting the mail.",
            "flags": {
                "nsfw": false,
                "religious": false,
                "political": false,
                "racist": false,
                "sexist": false,
                "explicit": false
            },
            "id": 81,
            "safe": true,
            "lang": "en"
        }
        """

        let joke = try await networkJokeRepository.joke(for: .any)

        XCTAssertEqual(false, joke.error)
        XCTAssertEqual("Misc", joke.category)
        XCTAssertEqual("twopart", joke.type)
        XCTAssertEqual("My wife left me because I'm too insecure and paranoid.", joke.setup)
        XCTAssertEqual("Oh wait, never mind. She was just getting the mail.", joke.delivery)
        XCTAssertEqual(false, joke.flags?.nsfw)
        XCTAssertEqual(false, joke.flags?.religious)
        XCTAssertEqual(false, joke.flags?.racist)
        XCTAssertEqual(false, joke.flags?.sexist)
        XCTAssertEqual(false, joke.flags?.explicit)

        XCTAssertEqual(81, joke.id)
        XCTAssertEqual(true, joke.safe)
        XCTAssertEqual("en", joke.lang)

    }
}
