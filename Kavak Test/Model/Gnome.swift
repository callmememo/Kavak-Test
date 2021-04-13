//
//  Gnome.swift
//  Kavak Test
//
//  Created by Memo on 4/13/21.
//

import Foundation

struct Gnome: Decodable {
    var id: Int
    var name: String
    var thumbnail: String
    var age: Int
    var weight: Double
    var height: Double
    var hairColor: String
    var professions: [String]
    var friends: [String]
}
