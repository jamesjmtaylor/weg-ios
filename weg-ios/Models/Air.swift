//
//  Air.swift
//  weg-ios
//
//  Created by Taylor, James on 4/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
import CoreData
@objc(Air)
class Air : NSManagedObject, Equipment  {
    var type = EquipmentType.AIR
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
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
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Land", in: context) else { fatalError() }
        self.init(entity: entity, insertInto: context)
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
        self.groupIconUrl = try container.decodeIfPresent(String.self, forKey: .groupIconUrl)
        self.individualIconUrl = try container.decodeIfPresent(String.self, forKey: .individualIconUrl)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        
        self.gun = try container.decodeIfPresent(Gun.self, forKey: .gun)
        self.agm = try container.decodeIfPresent(Gun.self, forKey: .agm)
        self.aam = try container.decodeIfPresent(Gun.self, forKey: .aam)
        self.asm = try container.decodeIfPresent(Gun.self, forKey: .asm)
        
        self.speed = try container.decode(Int64.self, forKey: .speed)
        self.auto = try container.decode(Int64.self, forKey: .auto)
        self.ceiling = try container.decode(Int64.self, forKey: .ceiling)
        self.weight = try container.decode(Int64.self, forKey: .weight)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(desc, forKey: .desc)
        try container.encode(groupIconUrl, forKey: .groupIconUrl)
        try container.encode(individualIconUrl, forKey: .individualIconUrl)
        try container.encode(photoUrl, forKey: .photoUrl)
        
        try container.encode(gun, forKey: .gun)
        try container.encode(agm, forKey: .agm)
        try container.encode(aam, forKey: .aam)
        try container.encode(asm, forKey: .asm)
        
        try container.encode(speed, forKey: .speed)
        try container.encode(auto, forKey: .auto)
        try container.encode(ceiling, forKey: .ceiling)
        try container.encode(weight, forKey: .weight)
    }
}
