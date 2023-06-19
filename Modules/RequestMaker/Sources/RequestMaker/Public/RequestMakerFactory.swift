import Foundation

public protocol RequestMakerFactory {
    func requestMaker() -> RequestMaker
}

final class AppRequestMakerFactory: RequestMakerFactory {
    func requestMaker() -> RequestMaker {
        NetworkRequestMaker()
    }
}
