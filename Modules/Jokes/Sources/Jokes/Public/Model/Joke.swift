import Foundation

public enum JokeCategory: String, CaseIterable {
    case any = "Any"
    case misc = "Misc"
    case programming = "Programming"
    case dark = "Dark"
    case pun = "Pun"
    case spooky = "Spooky"
    case christmas = "Christmas"

    static func from(string: String) -> JokeCategory? {
        return self.allCases.first{ $0.rawValue == string }
    }
}

public enum JokeDetails {
    case single(joke: String)
    case twopart(setup: String, delivery: String)
}

public struct Joke {
    let id: Int
    let category: JokeCategory
    let details: JokeDetails
}
