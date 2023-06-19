import XCTest

@testable import RequestMaker

final class AppRequestMakerFactoryTests: XCTestCase {

    func testFactoryReturnsNetworkRequestFactory() throws {
        let factory = AppRequestMakerFactory()
        let requestMaker = factory.requestMaker()
        XCTAssertTrue(requestMaker is NetworkRequestMaker, "requestMaker should be instance of NetworkRequestMaker")
    }
}
