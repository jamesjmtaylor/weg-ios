//
//  Land.swift
//  weg-ios
//
//  Created by Taylor, James on 4/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation

struct Land : Equipment {
    var id: Int = 0
    var name: String = ""
    var  description: String?
    var  groupIconUrl: String?
    var  individualIconUrl: String?
    var  photoUrl: String?
    var  primaryWeapon: Gun?
    var  secondaryWeapon: Gun?
    var  atgm: Gun?
    var  armor: Int?
    var  speed: Int?
    var  auto: Int?
    var  weight: Int?
    var  type = EquipmentType.LAND
}
