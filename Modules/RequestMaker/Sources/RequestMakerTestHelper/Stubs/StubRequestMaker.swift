import Foundation

import RequestMaker

public final class StubRequestMaker: RequestMaker {

    public var invokedMakeRequest = false
    public var invokedMakeRequestCount = 0
    public var invokedMakeRequestParameters: (url: URL, Void)?
    public var invokedMakeRequestParametersList = [(url: URL, Void)]()
    public var stubbedMakeRequestError: Error?
    public var stubbedMakeRequestResult: Data!

    public init() { }

    deinit {
        invokedMakeRequestParameters = nil
        invokedMakeRequestParametersList.removeAll()
        stubbedMakeRequestError = nil
        stubbedMakeRequestResult = nil
    }

    public func makeRequest(for url: URL) async throws -> Data {
        invokedMakeRequest = true
        invokedMakeRequestCount += 1
        invokedMakeRequestParameters = (url, ())
        invokedMakeRequestParametersList.append((url, ()))
        if let error = stubbedMakeRequestError {
            throw error
        }
        return stubbedMakeRequestResult
    }
}
