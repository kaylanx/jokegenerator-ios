import SwiftUI

@dynamicMemberLookup
public class ViewModelState<Value>: ObservableObject {

    @Published var value: Value

    public init(initialState: Value) {
        value = initialState
    }

    public func update(_ closure: (inout Value) -> Void) {
        var updated = value
        closure(&updated)
        value = updated
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<Value, T>) -> T {
        value[keyPath: keyPath]
    }
}
