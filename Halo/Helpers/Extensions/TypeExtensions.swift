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

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension UserDefaults {
    func updateUser(user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            self.set(encoded, forKey: "user")
        }
    }
    
    func retrieveUser() -> User? {
        if let user = self.data(forKey: "user") {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: user) {
                return loadedUser
            }
        }
        
        return nil
    }
}


extension Date {
    // yyyy-MM-dd HH:mm:ss
    func toString(format: String = "h:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
