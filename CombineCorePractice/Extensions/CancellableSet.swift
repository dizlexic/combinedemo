//
//  CancellableSet.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import Combine

typealias CancellableSet = Set<AnyCancellable>
extension CancellableSet {
    mutating func store(@CancellableBuilder _ cancellables: () -> [AnyCancellable]) {
        formUnion(cancellables())
    }
    
    @resultBuilder
    struct CancellableBuilder {
        static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
            return cancellables
        }
    }
}
