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
    @IBOutlet weak var groupIcnImageView: UIImageView!
    @IBOutlet weak var indIconImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var equipment : Equipment?
    override func viewDidLoad() {
        super.viewDidLoad()
        createEquipmentDetailRows()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createEquipmentDetailRows(){
        let numRows = 2 //TODO: Make numRows reflect number of equipment attributes
        stackViewHeight.constant = CGFloat(numRows * 45)
        for row in 0..<numRows {
            addRow(title: "Cool", value: "Value", header: true)
        }
    }
    
    // MARK: - Amenity toggle functions
    func addRow(title: String, value: String, header: Bool) {
        guard let toggleView = Bundle.main.loadNibNamed("EquipmentDetailRow", owner: self, options: nil)?.first as? EquipmentDetailRow else {return}
        toggleView.configure(title: title, value: value, header: header)
        self.stackView.addArrangedSubview(toggleView)
    }
}
