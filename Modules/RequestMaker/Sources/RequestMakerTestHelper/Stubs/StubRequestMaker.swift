import Foundation

import RequestMaker

public final class StubRequestMaker: RequestMaker {

    public var dataToReturn: Data!
    public var invokedMakeRequest = false
    public var invokedMakeRequestCount = 0
    public var invokedMakeRequestParameters: (url: URL, Void)?
    public var invokedMakeRequestParametersList = [(url: URL, Void)]()

    public init() { }

    deinit {
        invokedMakeRequestParameters = nil
    }

    public func makeRequest(for url: URL) async throws -> Data {
        invokedMakeRequest = true
        invokedMakeRequestCount += 1
        invokedMakeRequestParameters = (url, ())
        invokedMakeRequestParametersList.append((url, ()))
        return dataToReturn
    }
}
