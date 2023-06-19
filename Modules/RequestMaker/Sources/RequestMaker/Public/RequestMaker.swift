import Foundation

public protocol RequestMaker {
    func makeRequest(for url: URL) async throws -> Data
}
