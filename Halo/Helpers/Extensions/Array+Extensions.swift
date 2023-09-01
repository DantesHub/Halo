//
//  Array+Extensions.swift
//  Doxo
//
//

import Foundation
import SwiftUI

extension Array where Element: Equatable {
    func contains(array: [Element]) -> Bool {
        for item in array {
            if !contains(item) { return false }
        }
        return true
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
