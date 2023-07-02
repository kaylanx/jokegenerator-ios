import Observation

@Observable
@dynamicMemberLookup
public final class ViewModelState<Value> {

    var value: Value? = nil

    public init(initialState: Value) {
        value = initialState
    }

    public func update(_ closure: (inout Value) -> Void) {
        guard let value else { fatalError("Value must not be nil") }
        var updated = value
        closure(&updated)
        self.value = updated
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<Value, T>) -> T {
        guard let value else { fatalError("Value must not be nil") }
        return value[keyPath: keyPath]
    }
}
