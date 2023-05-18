//
//  JokeRepository.swift
//  
//  Created by Andy Kayley on 18/05/2023.
//

import Foundation

enum JokeCategory: String {
    case any
}

protocol JokeRepository {
    func joke(for category: JokeCategory) async throws -> JokeDto
}
