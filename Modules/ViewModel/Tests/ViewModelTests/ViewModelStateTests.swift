import XCTest
@testable import ViewModel


struct TestState {
    var fooBar: Bool
}

final class ViewModelTests: XCTestCase {

    func testStateUpdates() throws {
        let state = ViewModelState(initialState: TestState(fooBar: false))

        let value = try XCTUnwrap(state.value)
        XCTAssertFalse(value.fooBar)
        XCTAssertFalse(state.fooBar)
        XCTAssertEqual(value.fooBar, state.fooBar)

        state.update { state in
            state.fooBar = true
        }

        let updatedValue = try XCTUnwrap(state.value)

        XCTAssertTrue(state.fooBar)
        XCTAssertEqual(updatedValue.fooBar, state.fooBar)
    }
}
