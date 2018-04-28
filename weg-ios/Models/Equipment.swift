//
//  Equipment.swift
//  weg-ios
//
//  Created by Taylor, James on 4/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
protocol Equipment : Codable {
    var id : Int {get set}
    var name : String {get set}
    var photoUrl: String? {get set}
    var type : EquipmentType {get set}
    
    
}
struct CombinedList : Codable {
    let gun : [Gun]
    let land : [Land]
    let sea : [Sea]
    let air : [Air]
    
    func getEquipment() -> [Equipment] {
        var equipmentList = [Equipment]()
        equipmentList.append(contentsOf: gun)
        equipmentList.append(contentsOf: land)
        equipmentList.append(contentsOf: sea)
        equipmentList.append(contentsOf: air)
        return equipmentList
    }
}
enum EquipmentType: String, Codable {
    case LAND
    case SEA
    case AIR
    case GUN
    case ALL
}
