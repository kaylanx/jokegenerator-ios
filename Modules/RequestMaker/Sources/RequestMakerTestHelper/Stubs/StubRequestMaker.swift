//
//  StubRequestMaker.swift
//  
//  Created by Andy Kayley on 18/05/2023.
//
import Foundation
import RequestMaker

public final class StubRequestMaker: RequestMaker {
    var jsonJokeToReturn: String = "{ }"
    var errorToThrow: Error?

    var makeRequestCalled: Bool = false
    public func makeRequest(for url: String) async throws -> Data {
        makeRequestCalled = true

        if let errorToThrow {
            throw errorToThrow
        }
        return jsonJokeToReturn.data(using: .utf8)!
    }
}
