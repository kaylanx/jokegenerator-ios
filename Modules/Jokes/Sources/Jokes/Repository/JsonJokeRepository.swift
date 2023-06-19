import Foundation

import RequestMaker

final class JsonJokeRepository: JokeRepository {

    let requestMaker: RequestMaker

    init(requestMaker: RequestMaker) {
        self.requestMaker = requestMaker
    }

    func joke(for category: JokeCategory) async throws -> JokeDto {
        let jsonData = try await requestMaker.makeRequest(for: URL(string: "https://v2.jokeapi.dev/joke/\(category)")!)
        let jokeDto = try JSONDecoder().decode(JokeDto.self, from: jsonData)
        try throwIfError(jokeDto: jokeDto)
        return jokeDto
    }

    private func throwIfError(jokeDto: JokeDto) throws {
        if jokeDto.error == true {
            let jokeErrorDetails = JokeRepositoryError.JokeErrorDetails(
                code: jokeDto.code,
                message: jokeDto.message,
                causedBy: jokeDto.causedBy,
                additionalInfo: jokeDto.additionalInfo,
                timestamp: jokeDto.timestamp
            )

            if jokeDto.internalError == true {
                throw JokeRepositoryError.internal(jokeErrorDetails)
            }

            throw JokeRepositoryError.client(jokeErrorDetails)
        }
    }
}
