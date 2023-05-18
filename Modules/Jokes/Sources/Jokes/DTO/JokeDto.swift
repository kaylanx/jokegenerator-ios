//
//  JokeDto.swift
//  
//  Created by Andy Kayley on 18/05/2023.
//

import Foundation

struct JokeDto: Decodable {
    let id: Int?
    let error: Bool?
    let category: String?
    let type: String?
    let joke: String?
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
