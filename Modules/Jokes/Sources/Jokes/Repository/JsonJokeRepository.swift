//
//  JsonJokeRepository.swift
//
//  Created by Andy Kayley on 18/05/2023.
//
import Foundation

import RequestMaker

final class JsonJokeRepository: JokeRepository {

    let requestMaker: RequestMaker

    init(requestMaker: RequestMaker) {
        self.requestMaker = requestMaker
    }

    func joke(for category: JokeCategory) async throws -> JokeDto {
        let jsonData = try await requestMaker.makeRequest(for: "https://v2.jokeapi.dev/joke/\(category)")
        return try JSONDecoder().decode(JokeDto.self, from: jsonData)
    }
}
