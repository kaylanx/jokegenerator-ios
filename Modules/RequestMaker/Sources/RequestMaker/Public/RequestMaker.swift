//
//  RequestMaker.swift
//
//  Created by Andy Kayley on 18/05/2023.
//

import Foundation

public protocol RequestMaker {
    func makeRequest(for url: String) async throws -> Data
}
