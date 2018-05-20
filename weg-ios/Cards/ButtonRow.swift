//
//  ButtonRow.swift
//  weg-ios
//
//  Created by Taylor, James on 5/14/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import UIKit

protocol ButtonRowDelegate {
    func buttonPressed(buttonText: String?)
}

class ButtonRow: UIView {
    var delegate : ButtonRowDelegate?
    var correctAnswer : String?
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    func configure(option0: String, option1: String, option2: String, correctAnser: String) {
        button0.isEnabled = true
        button1.isEnabled = true
        button2.isEnabled = true
        button0.setTitle(option0, for: .normal)
        button1.setTitle(option1, for: .normal)
        button2.setTitle(option2, for: .normal)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        delegate?.buttonPressed(buttonText: sender.titleLabel?.text)
    }

}
