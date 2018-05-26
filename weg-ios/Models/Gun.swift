//
//  Gun.swift
//  weg-ios
//
//  Created by Taylor, James on 4/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
import CoreData
@objc(Gun)
class Gun : NSManagedObject, Equipment {
    var type = EquipmentType.GUN
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case groupIconUrl
        case individualIconUrl
        case photoUrl
        case penetration
        case altitude
        case range
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Gun", in: context) else { fatalError() }
        self.init(entity: entity, insertInto: context)
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
        self.groupIconUrl = try container.decodeIfPresent(String.self, forKey: .groupIconUrl)
        self.individualIconUrl = try container.decodeIfPresent(String.self, forKey: .individualIconUrl)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.penetration = try container.decode(Int64.self, forKey: .penetration)
        self.altitude = try container.decode(Int64.self, forKey: .altitude)
        self.range = try container.decode(Int64.self, forKey: .range)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(desc, forKey: .desc)
        try container.encode(groupIconUrl, forKey: .groupIconUrl)
        try container.encode(individualIconUrl, forKey: .individualIconUrl)
        try container.encode(photoUrl, forKey: .photoUrl)
        try container.encode(penetration, forKey: .penetration)
        try container.encode(altitude, forKey: .altitude)
        try container.encode(range, forKey: .range)
    }
}
