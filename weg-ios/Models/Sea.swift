//
//  Sea.swift
//  weg-ios
//
//  Created by Taylor, James on 4/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
import CoreData

class Sea : NSManagedObject, Equipment {
    var type = EquipmentType.SEA
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case individualIconUrl
        case photoUrl
        
        case gun
        case sam
        case asm
        case torpedo
        
        case transports
        case qty
        case dive
        case speed
        case auto
        case tonnage
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Sea", in: context) else { fatalError() }
        self.init(entity: entity, insertInto: context)
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
        self.individualIconUrl = try container.decodeIfPresent(String.self, forKey: .individualIconUrl)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        
        self.gun = try container.decodeIfPresent(Gun.self, forKey: .gun)
        self.sam = try container.decodeIfPresent(Gun.self, forKey: .sam)
        self.asm = try container.decodeIfPresent(Gun.self, forKey: .asm)
        self.torpedo = try container.decodeIfPresent(Gun.self, forKey: .torpedo)
        
        self.transports = try container.decodeIfPresent(String.self, forKey: .transports)
        self.qty = try container.decode(Int64.self, forKey: .qty)
        self.dive = try container.decode(Int64.self, forKey: .dive)
        self.speed = try container.decode(Int64.self, forKey: .speed)
        self.auto = try container.decode(Int64.self, forKey: .auto)
        self.tonnage = try container.decode(Int64.self, forKey: .tonnage)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(desc, forKey: .desc)
        try container.encode(individualIconUrl, forKey: .individualIconUrl)
        try container.encode(photoUrl, forKey: .photoUrl)
        
        try container.encode(gun, forKey: .gun)
        try container.encode(sam, forKey: .sam)
        try container.encode(asm, forKey: .asm)
        try container.encode(torpedo, forKey: .torpedo)
        
        try container.encode(transports, forKey: .transports)
        try container.encode(qty, forKey: .qty)
        try container.encode(dive, forKey: .dive)
        try container.encode(speed, forKey: .speed)
        try container.encode(auto, forKey: .auto)
        try container.encode(tonnage, forKey: .tonnage)
    }
}
