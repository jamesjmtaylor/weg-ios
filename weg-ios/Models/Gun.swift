//
//  Gun.swift
//  weg-ios
//
//  Created by Taylor, James on 4/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
import CoreData

struct Gun : Equipment, NSManagedObject {
    var id: Int
    var name: String
    var desc: String?
    var groupIconUrl: String?
    var individualIconUrl: String?
    var penetration: Int?
    var altitude: Int?
    var photoUrl: String?
    var range: Int?
    var type = EquipmentType.GUN
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case groupIconUrl
        case individualIconUrl
        case penetration
        case altitude
        case photoUrl
        case range
    }
}
