import Foundation

enum JokeDtoAdapterError: Error {
    case idNull
    case invalidType(String)
    case invalidCategory(String)
}

final class JokeDtoAdapter {
    func adapt(jokeDto: JokeDto) throws -> Joke {

        guard let id = jokeDto.id else {
            throw JokeDtoAdapterError.idNull
        }

        let category = try adaptCategory(jokeDto: jokeDto)
        let details = try adaptDetails(jokeDto: jokeDto)

        return Joke(id: id, category: category, details: details)
    }

    private func adaptDetails(jokeDto: JokeDto) throws -> JokeDetails {
        if jokeDto.type == "single" {
            return JokeDetails.single(joke: jokeDto.joke ?? "")
        }

        if jokeDto.type == "twopart" {
            return JokeDetails.twopart(setup: jokeDto.setup ?? "", delivery: jokeDto.delivery ?? "")
        }

        throw JokeDtoAdapterError.invalidType("\(String(describing: jokeDto.type)) is invalid")
    }

    private func adaptCategory(jokeDto: JokeDto) throws -> JokeCategory {
        guard let category = jokeDto.category, let jokeCategory = JokeCategory.from(string: category) else {
            throw JokeDtoAdapterError.invalidCategory("\(String(describing: jokeDto.category)) is invalid")
        }
        return jokeCategory
    }
}