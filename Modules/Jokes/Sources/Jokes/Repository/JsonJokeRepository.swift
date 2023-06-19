import Foundation

import RequestMaker

final class JsonJokeRepository: JokeRepository {

    let requestMaker: RequestMaker

    init(requestMaker: RequestMaker) {
        self.requestMaker = requestMaker
    }

    func joke(for category: JokeCategory) async throws -> JokeDto {
        let jsonData = try await requestMaker.makeRequest(for: URL(string: "https://v2.jokeapi.dev/joke/\(category)")!)
        return try JSONDecoder().decode(JokeDto.self, from: jsonData)
    }
}
