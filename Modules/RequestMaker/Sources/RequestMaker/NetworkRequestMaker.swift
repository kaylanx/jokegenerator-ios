import Foundation

final class NetworkRequestMaker: RequestMaker {
    func makeRequest(for url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
