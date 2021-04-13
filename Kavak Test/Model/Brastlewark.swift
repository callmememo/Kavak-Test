//
//  Brastlewark.swift
//  Kavak Test
//
//  Created by Memo on 4/13/21.
//

import Foundation

struct Brastlewark: Decodable {
    
    var brastlewark: [Gnome]
    
    private enum CodingKeys : String, CodingKey {
        case brastlewark = "Brastlewark"
    }
}
