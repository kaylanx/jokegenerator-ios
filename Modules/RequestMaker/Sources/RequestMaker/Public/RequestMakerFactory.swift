import Foundation

public protocol RequestMakerFactory {
    func requestMaker() -> RequestMaker
}

public final class AppRequestMakerFactory: RequestMakerFactory {

    public init() { }

    public func requestMaker() -> RequestMaker {
        NetworkRequestMaker()
    }
}
