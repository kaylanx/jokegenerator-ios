import Testing

@testable import RequestMaker

struct AppRequestMakerFactoryTests {
    @Test
    func factoryReturnsNetworkRequestFactory() {
        let factory = AppRequestMakerFactory()
        let requestMaker = factory.requestMaker()
        #expect(requestMaker is NetworkRequestMaker)
    }
}
