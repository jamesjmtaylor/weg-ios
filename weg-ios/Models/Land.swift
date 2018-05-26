//
//  Land.swift
//  weg-ios
//
//  Created by Taylor, James on 4/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
import CoreData

struct Land : Equipment, NSManagedObject {
    var id: Int = 0
    var name: String = ""
    var desc: String?
    var groupIconUrl: String?
    var individualIconUrl: String?
    var photoUrl: String?
    var primaryWeapon: Gun?
    var secondaryWeapon: Gun?
    var atgm: Gun?
    var armor: Int?
    var speed: Int?
    var auto: Int?
    var weight: Int?
    var type = EquipmentType.LAND
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case groupIconUrl
        case individualIconUrl
        case photoUrl
        case primaryWeapon
        case secondaryWeapon
        case atgm
        case armor
        case speed
        case auto
        case weight
    }
}
