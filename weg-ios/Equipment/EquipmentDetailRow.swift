//
//  EquipmentDetailRow.swift
//  weg-ios
//
//  Created by Taylor, James on 5/9/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import UIKit

class EquipmentDetailRow: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    func configure(title: String, value: String, header: Bool) {
        titleLabel.text = title
        valueLabel.text = value
        if header {
            titleLabel.addAttributes(isBolded: true, isUnderlined: true)
            valueLabel.addAttributes(isBolded: true, isUnderlined: true)
        }
    }

}
