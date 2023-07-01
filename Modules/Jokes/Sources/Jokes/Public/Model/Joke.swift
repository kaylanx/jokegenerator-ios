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
    public let id: Int
    public let category: JokeCategory
    public let details: JokeDetails

    public init(id: Int, category: JokeCategory, details: JokeDetails) {
        self.id = id
        self.category = category
        self.details = details
    }
}
