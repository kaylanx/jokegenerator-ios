//
//  ViewModelState.swift
//  SwiftUIAndTDDExample
//
//  Created by Andy Kayley on 17/05/2023.
//

import SwiftUI

@dynamicMemberLookup
class ViewModelState<Value>: ObservableObject {

    @Published var value: Value

    init(initialState: Value) {
        value = initialState
    }

    func update(_ closure: (inout Value) -> Void) {
        var updated = value
        closure(&updated)
        value = updated
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<Value, T>) -> T {
        value[keyPath: keyPath]
    }
}
