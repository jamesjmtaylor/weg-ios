//
//  Equipment.swift
//  weg-ios
//
//  Created by Taylor, James on 4/24/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
import UIKit
protocol Equipment : Codable {
    var id : Int {get set}
    var name : String {get set}
    var photoUrl: String? {get set}
    var type : EquipmentType {get set}
}
extension Equipment {
    private func getPhotoUIImage(completionHandler : @escaping (UIImage) ->()) -> UIImage? {
        guard let imageUrl = self.photoUrl else {return nil}
        if let photo = Filesystem.getImageFrom(fileName: imageUrl){ //see if image is cached
            return photo
        } else if let url = URL(string: EquipmentRepository.baseUrl() + imageUrl){
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else {return}
                guard let image = UIImage(data: data) else {return}
                Filesystem.saveImageTo(image: image, fileName: imageUrl)
                completionHandler(image)
            }
        }
        return nil
    }
    func setImageView(imageView: UIImageView) {
        if let image = getPhotoUIImage(completionHandler: { (image) in
            DispatchQueue.main.async {imageView.image = image}})
        {
            imageView.image = image
        }
    }
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
