//
//  EquipmentCollectionViewCell.swift
//  weg-ios
//
//  Created by Taylor, James on 4/29/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import UIKit
import Kingfisher

class EquipmentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

        func configure(e: Equipment){
                nameLabel.text = e.name
                guard let imageUrl = e.photoUrl else {return}
                guard let url = URL(string: EquipmentRepository.baseUrl() + imageUrl) else {return}
                imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
        }
    }
