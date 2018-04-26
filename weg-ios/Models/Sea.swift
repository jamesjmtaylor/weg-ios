//
//  Sea.swift
//  weg-ios
//
//  Created by Taylor, James on 4/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation

class Sea : Equipment {
    var id: Int = 0
    var name: String = ""
    var  description: String?
    var  individualIconUrl: String?
    var photoUrl: String?
    
    var  gun: Gun?
    var  sam: Gun?
    var  asm: Gun?
    var  torpedo: Gun?
    
    var  transports: String?
    var  qty: Int?
    var  dive: Int?
    var  speed: Int?
    var  auto: Int?
    var  tonnage: Int?
    var type = EquipmentType.SEA
}
