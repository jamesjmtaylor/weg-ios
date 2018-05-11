//
//  EquipmentViewController.swift
//  weg-ios
//
//  Created by Taylor, James on 4/29/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import UIKit

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
        setImage(photoImageView, equipmentToView?.photoUrl)
    }
    
    func configureViewToEquipmentType(item: Equipment?){
        descriptionLabel.text = "Description: "
        descriptionLabel?.bold()
        
        if let item = item as? Gun {
            setImage(groupImageView, item.groupIconUrl)
            setImage(individualImageView, item.individualIconUrl)
            descriptionLabel.text?.append(item.description ?? "")
            setDetailViews(gun: item)
        } else if let item = item as? Land {
            setImage(groupImageView, item.groupIconUrl)
            setImage(individualImageView, item.individualIconUrl)
            descriptionLabel.text?.append(item.description ?? "")
            setDetailViews(land: item)
        } else if let item = item as? Sea {
            setImage(individualImageView, item.individualIconUrl)
            descriptionLabel.text?.append(item.description ?? "")
            groupImageView?.isHidden = true
            setDetailViews(sea: item)
        } else if let item = item as? Air {
            setImage(groupImageView, item.groupIconUrl)
            setImage(individualImageView, item.individualIconUrl)
            descriptionLabel.text?.append(item.description ?? "")
            setDetailViews(air: item)
        }
        adjustStackViewHeight(stackViewHeight: self.stackViewHeight,
                              numRows: self.numRows, rowHeight: self.rowHeight)
    }
    func setImage(_ imageView: UIImageView ,_ url: String?){
        guard let imageUrl = url else {return}
        guard let url = URL(string: EquipmentRepository.baseUrl() + imageUrl) else {return}
        imageView.kf.setImage(with: url, options: nil)
    }
    
    // MARK: - Detail Row Logic
    var numRows = 0
    var rowHeight = 45
    func createDetailRow(_ title: String, _ value: String, _ header: Bool = false) {
        guard let toggleView = Bundle.main.loadNibNamed("EquipmentDetailRow", owner: self, options: nil)?.first as? EquipmentDetailRow else {return}
        toggleView.configure(title: title, value: value, header: header)
        self.stackView.addArrangedSubview(toggleView)
        numRows += 1
    }
    func adjustStackViewHeight(stackViewHeight: NSLayoutConstraint, numRows: Int, rowHeight: Int){
        stackViewHeight.constant = CGFloat(numRows * rowHeight)
    }
    func setDetailViews(gun: Gun){
        if (gun.range ?? 0 > 0 ) {createDetailRow("Range",gun.range!.description+" meters")}
        if (gun.altitude ?? 0 > 0 ) {createDetailRow("Altitude",gun.altitude!.description+" meters")}
        if (gun.penetration ?? 0 > 0 ) {createDetailRow("Penetration",gun.penetration!.description+"mm")}
    }
    func setDetailViews(land: Land){
        if let it = land.primaryWeapon {
            createDetailRow("Primary Weapon",it.name, true)
            if (it.range ?? 0 > 0 ) {createDetailRow("Range",it.range!.description+" meters")}
            if (it.altitude ?? 0 > 0){createDetailRow("Altitude",it.altitude!.description+" meters") }
            if (it.penetration ?? 0 > 0){createDetailRow("Penetration",it.penetration!.description+"mm") }
        }
        if let it = land.secondaryWeapon {
            createDetailRow("Secondary Weapon",it.name, true)
            if (it.range ?? 0 > 0 ) {createDetailRow("Range",it.range!.description+" meters")}
            if (it.altitude ?? 0 > 0){createDetailRow("Altitude",it.altitude!.description+" meters") }
            if (it.penetration ?? 0 > 0){createDetailRow("Penetration",it.penetration!.description+"mm") }
        }
        if let it = land.atgm {
            createDetailRow("ATGM",it.name, true)
            createDetailRow("Range",it.range!.description+" meters")
            createDetailRow("Penetration",it.penetration!.description+"mm")
        }
        if let it = land.armor{ if (it > 0){createDetailRow("Armor",it.description+"mm", true)}}
        if let it = land.speed{ if (it > 0){createDetailRow("Speed",it.description+" kph", true)}}
        if let it = land.auto{ if (it > 0){createDetailRow("Autonomy",it.description+" km", true)}}
        if let it = land.weight{ if (it > 0){createDetailRow("Weight",it.description+" tons", true)}}
    }
    func setDetailViews(sea: Sea){
        if let it = sea.gun {
            createDetailRow("Deck Gun",it.name, true)
            if (it.range ?? 0 > 0 ) {createDetailRow("Range",it.range!.description+" meters")}
            if (it.altitude ?? 0 > 0){createDetailRow("Altitude",it.altitude!.description+" meters") }
            if (it.penetration ?? 0 > 0){createDetailRow("Penetration",it.penetration!.description+"mm") }
        }
        if let it =  sea.asm {
            createDetailRow("Anti-Ship Missile",it.name, true)
            if (it.range ?? 0 > 0 ) {createDetailRow("Range",it.range!.description+" meters")}
            if (it.altitude ?? 0 > 0){createDetailRow("Altitude",it.altitude!.description+" meters") }
            if (it.penetration ?? 0 > 0){createDetailRow("Penetration",it.penetration!.description+"mm") }
        }
        if let it = sea.sam {
            createDetailRow("Surface-to-Air Missile",it.name, true)
            if (it.range ?? 0 > 0 ) {createDetailRow("Range",it.range!.description+" meters")}
            if (it.altitude ?? 0 > 0){createDetailRow("Altitude",it.altitude!.description+" meters") }
            if (it.penetration ?? 0 > 0){createDetailRow("Penetration",it.penetration!.description+"mm") }
        }
        if let it = sea.torpedo {
            createDetailRow("Torpedo",it.name, true)
            if (it.range ?? 0 > 0 ) {createDetailRow("Range",it.range!.description+" meters")}
        }
        if (!(sea.transports?.isEmpty ?? true || sea.transports?.contains("null") ?? true)){
            createDetailRow("Transports",sea.transports?.description ?? "", true)
            if (sea.qty ?? 0 > 0){createDetailRow("Quantity",sea.qty!.description) }
        }
        if (sea.dive ?? 0 > 0) {createDetailRow("Maximum Depth",sea.dive!.description+" meters", true)}
        if let it = sea.speed { createDetailRow("Speed",it.description+" kph", true) }
        if let it = sea.auto { createDetailRow("Autonomy",it.description+" km", true) }
        if let it = sea.tonnage { createDetailRow("Displacement",it.description+" tons", true) }
    }
    func setDetailViews(air: Air){
        if let it = air.gun{
            createDetailRow("Cannon",it.name, true)
            if (it.range ?? 0 > 0 ) {createDetailRow("Range",it.range!.description+" meters")}
            if (it.penetration ?? 0 > 0){createDetailRow("Penetration",it.penetration!.description+"mm") }
        }
        if let it = air.agm{
            createDetailRow("Air-to-Ground Missile",it.name, true)
            if (it.range ?? 0 > 0 ) {createDetailRow("Range",it.range!.description+" meters")}
            createDetailRow("Penetration",it.penetration!.description+"mm")
        }
        if let it = air.asm {
            createDetailRow("Air-to-Surface Missile",it.name, true)
            if (it.range ?? 0 > 0 ) {createDetailRow("Range",it.range!.description+" meters")}
        }
        if let it = air.aam {
            createDetailRow("Air-to-Air Missile",it.name, true)
            if (it.range ?? 0 > 0 ) {createDetailRow("Range",it.range!.description+" meters")}
        }
        if let it = air.speed { createDetailRow("Speed",it.description+" kph", true) }
        if let it = air.ceiling { createDetailRow("Ceiling",it.description+" meters", true) }
        if let it = air.auto { createDetailRow("Autonomy",it.description+" km", true) }
        if let it = air.weight { createDetailRow("Weight",it.description+" kg", true) }
    }
    
    // MARK: - Buttons
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
