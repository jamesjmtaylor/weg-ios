//
//  Equipment.swift
//  weg-ios
//
//  Created by Taylor, James on 4/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol Equipment : Codable {
    var id : Int64 {get set}
    var name : String? {get set}
    var photoUrl: String? {get set}
    var individualIconUrl: String? {get set}
    var type : EquipmentType {get set}
}

func sortAndFilterEquipment(equipment: [Equipment]) -> [Equipment] {
    let photosOnly = equipment.filter({ (e) -> Bool in  return e.photoUrl != nil})
    let unique = removeDuplicates(photosOnly)
    let sorted = unique.sorted { (this, that) -> Bool in
        return this.name ?? "" < that.name ?? ""
    }
    return sorted
}
//This is manual implementation is necesary because protocols can't conform to Hashable, which prevents
//the use of the Set data structure.
func removeDuplicates(_ equipment: [Equipment]) -> [Equipment] {
    var results = [Equipment]()
    var exists = false
    for e in equipment {
        for r in results {
            if (e.name == r.name) {
                exists = true
                break
            }
            exists = false
        }
        if exists {
            exists = false
            continue
        } else {
            results.append(e)
        }
        
    }
    return results
}

struct CombinedList : Codable {
    let guns : [Gun]
    let land : [Land]
    let sea : [Sea]
    let air : [Air]
    
    func getEquipment() -> [Equipment] {
        var equipmentList = [Equipment]()
        equipmentList.append(contentsOf: guns)
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



