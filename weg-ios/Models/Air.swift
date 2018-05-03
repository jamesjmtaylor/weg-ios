//
//  Air.swift
//  weg-ios
//
//  Created by Taylor, James on 4/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation

class Air : Equipment {
    var id: Int = 0
    var name: String = ""
    var description: String?
    var groupIconUrl: String?
    var individualIconUrl: String?
    var photoUrl: String?
    
    var  gun: Gun?
    var  agm: Gun?
    var  aam: Gun?
    var  asm: Gun?
    
    var  speed: Int?
    var  auto: Int?
    var  ceiling: Int?
    var  weight: Int?
    var type = EquipmentType.AIR
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case groupIconUrl
        case individualIconUrl
        case photoUrl
        
        case gun
        case agm
        case aam
        case asm
        
        case speed
        case auto
        case ceiling
        case weight
    }
}
