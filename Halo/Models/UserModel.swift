//
//  UserModel.swift
//  Halo
//
//  Created by Dante Kim on 10/21/23.
//

import Foundation

struct User: Codable {
    var name: String
    var avgScreentime: String
    var coins: Int
    var guardians: [String]
    var dateJoined: Date
    var schedules: [Schedule]
    var limits: [Limit]
}


var exampleUser = User(name: "goat", avgScreentime: "2-4", coins: 100, guardians: [], dateJoined: Date(), schedules: [], limits: [])
