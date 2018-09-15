//
//  EquipmentViewController.swift
//  weg-ios
//
//  Created by Taylor, James on 4/29/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import UIKit
import Crashlytics

class EquipmentViewController: UIViewController{

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var individualImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var equipmentToView : Equipment?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewToEquipmentType(item: equipmentToView)
        EquipmentRepository.setImage(photoImageView, equipmentToView?.photoUrl)
    }
    
    func configureViewToEquipmentType(item: Equipment?){
        self.navigationItem.title = item?.name
        
        let formattedString = NSMutableAttributedString()
        if let item = item as? Gun {
            EquipmentRepository.setImage(groupImageView, item.groupIconUrl)
            EquipmentRepository.setImage(individualImageView, item.individualIconUrl)
            formattedString.bold("Description: ").normal(item.desc ?? "")
            descriptionLabel.attributedText = formattedString

            setDetailViews(gun: item)
        } else if let item = item as? Land {
            EquipmentRepository.setImage(groupImageView, item.groupIconUrl)
            EquipmentRepository.setImage(individualImageView, item.individualIconUrl)
            formattedString.bold("Description: ").normal(item.desc ?? "")
            descriptionLabel.attributedText = formattedString

            setDetailViews(land: item)
        } else if let item = item as? Sea {
            EquipmentRepository.setImage(individualImageView, item.individualIconUrl)
            formattedString.bold("Description: ").normal(item.desc ?? "")
            descriptionLabel.attributedText = formattedString

            groupImageView?.isHidden = true
            setDetailViews(sea: item)
        } else if let item = item as? Air {
            EquipmentRepository.setImage(groupImageView, item.groupIconUrl)
            EquipmentRepository.setImage(individualImageView, item.individualIconUrl)
            formattedString.bold("Description: ").normal(item.desc ?? "")
            descriptionLabel.attributedText = formattedString

            setDetailViews(air: item)
        }
        adjustStackViewHeight(stackViewHeight: self.stackViewHeight,
                              numRows: self.numRows, rowHeight: self.rowHeight)
    }
    
    // MARK: - Detail Row Logic
    var numRows = 0
    var rowHeight = 28
    func createDetailRow(_ title: String, _ value: String, _ header: Bool = false) {
        guard let detailRowView = Bundle.main.loadNibNamed("EquipmentDetailRow", owner: self, options: nil)?.first as? EquipmentDetailRow else {return}
        let frame = CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: rowHeight)
        detailRowView.frame = frame
        detailRowView.configure(title: title, value: value, header: header)
        self.stackView.addArrangedSubview(detailRowView)
        numRows += 1
    }
    func adjustStackViewHeight(stackViewHeight: NSLayoutConstraint, numRows: Int, rowHeight: Int){
        stackViewHeight.constant = CGFloat(numRows * rowHeight)
        stackView.layoutIfNeeded()
    }
    func setDetailViews(gun: Gun){
        if (gun.range > 0 ) {createDetailRow("Range",gun.range.description+" meters")}
        if (gun.altitude > 0 ) {createDetailRow("Altitude",gun.altitude.description+" meters")}
        if (gun.penetration > 0 ) {createDetailRow("Penetration",gun.penetration.description+"mm")}
    }
    func setDetailViews(land: Land){
        if let it = land.primaryWeapon {
            createDetailRow("Primary Weapon",it.name ?? "", true)
            if (it.range > 0 ) {createDetailRow("Range",it.range.description+" meters")}
            if (it.altitude > 0){createDetailRow("Altitude",it.altitude.description+" meters") }
            if (it.penetration > 0){createDetailRow("Penetration",it.penetration.description+"mm") }
        }
        if let it = land.secondaryWeapon {
            createDetailRow("Secondary Weapon",it.name ?? "", true)
            if (it.range > 0 ) {createDetailRow("Range",it.range.description+" meters")}
            if (it.altitude > 0){createDetailRow("Altitude",it.altitude.description+" meters") }
            if (it.penetration > 0){createDetailRow("Penetration",it.penetration.description+"mm") }
        }
        if let it = land.atgm {
            createDetailRow("ATGM",it.name ?? "", true)
            createDetailRow("Range",it.range.description+" meters")
            createDetailRow("Penetration",it.penetration.description+"mm")
        }
        if (land.armor > 0){createDetailRow("Armor",land.armor.description+"mm", true)}
        if (land.speed > 0){createDetailRow("Speed",land.speed.description+" kph", true)}
        if (land.auto > 0){createDetailRow("Autonomy",land.auto.description+" km", true)}
        if (land.weight > 0){createDetailRow("Weight",land.weight.description+" tons", true)}
    }
    func setDetailViews(sea: Sea){
        if let it = sea.gun {
            createDetailRow("Deck Gun",it.name ?? "", true)
            if (it.range > 0 ) {createDetailRow("Range",it.range.description+" meters")}
            if (it.altitude > 0){createDetailRow("Altitude",it.altitude.description+" meters")}
            if (it.penetration > 0){createDetailRow("Penetration",it.penetration.description+"mm")}
        }
        if let it =  sea.asm {
            createDetailRow("Anti-Ship Missile",it.name ?? "", true)
            if (it.range > 0 ) {createDetailRow("Range",it.range.description+" meters")}
            if (it.altitude > 0){createDetailRow("Altitude",it.altitude.description+" meters") }
            if (it.penetration > 0){createDetailRow("Penetration",it.penetration.description+"mm") }
        }
        if let it = sea.sam {
            createDetailRow("Surface-to-Air Missile",it.name ?? "", true)
            if (it.range > 0 ) {createDetailRow("Range",it.range.description+" meters")}
            if (it.altitude > 0){createDetailRow("Altitude",it.altitude.description+" meters") }
            if (it.penetration > 0){createDetailRow("Penetration",it.penetration.description+"mm") }
        }
        if let it = sea.torpedo {
            createDetailRow("Torpedo",it.name ?? "", true)
            if (it.range > 0 ) {createDetailRow("Range",it.range.description+" meters")}
        }
        if ((sea.transports?.isEmpty ?? true || sea.transports?.contains("null") ?? true)){
            createDetailRow("Transports",sea.transports?.description ?? "", true)
            if (sea.qty > 0){createDetailRow("Quantity",sea.qty.description) }
        }
        if (sea.dive > 0) {createDetailRow("Maximum Depth",sea.dive.description+" meters", true)}
        createDetailRow("Speed",sea.speed.description+" kph", true)
        createDetailRow("Autonomy",sea.auto.description+" km", true)
        createDetailRow("Displacement",sea.tonnage.description+" tons", true)
    }
    func setDetailViews(air: Air){
        if let it = air.gun{
            createDetailRow("Cannon",it.name ?? "", true)
            if (it.range > 0 ) {createDetailRow("Range",it.range.description+" meters")}
            if (it.penetration > 0){createDetailRow("Penetration",it.penetration.description+"mm") }
        }
        if let it = air.agm{
            createDetailRow("Air-to-Ground Missile",it.name ?? "", true)
            if (it.range > 0 ) {createDetailRow("Range",it.range.description+" meters")}
            createDetailRow("Penetration",it.penetration.description+"mm")
        }
        if let it = air.asm {
            createDetailRow("Air-to-Surface Missile",it.name ?? "", true)
            if (it.range > 0 ) {createDetailRow("Range",it.range.description+" meters")}
        }
        if let it = air.aam {
            createDetailRow("Air-to-Air Missile",it.name ?? "", true)
            if (it.range > 0 ) {createDetailRow("Range",it.range.description+" meters")}
        }
        createDetailRow("Speed",air.speed.description+" kph", true)
        createDetailRow("Ceiling",air.ceiling.description+" meters", true)
        createDetailRow("Autonomy",air.auto.description+" km", true)
        createDetailRow("Weight",air.weight.description+" kg", true)
    }
    
    // MARK: - Buttons
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
