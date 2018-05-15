//
//  CardsSetupViewController.swift
//  weg-ios
//
//  Created by Taylor, James on 5/14/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import UIKit

class CardsSetupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var qtyStepper: UIStepper!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "WEG 2015"
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(1,inComponent:0,animated:false)
        qtyStepper.stepValue = 5.0
        qtyStepper.minimumValue = 5.0
        qtyStepper.maximumValue = 100.0
    }


    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    // MARK: - PickerView
    @IBOutlet weak var difficultyPicker: UIPickerView!
    let difficultyChoices = ["Easy","Medium","Hard"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return difficultyChoices.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficultyChoices[row]
    }
    
    // MARK: - Buttons
    @IBOutlet weak var weaponsSwitch: UISwitch!
    @IBOutlet weak var landSwitch: UISwitch!
    @IBOutlet weak var seaSwitch: UISwitch!
    @IBOutlet weak var airSwitch: UISwitch!
    
    @IBOutlet weak var qtyLabel: UILabel!
    @IBAction func qtyStepperPressed(_ sender: UIStepper) {
        qtyLabel.text = Int(sender.value).description
    }
    @IBAction func startButtonPressed(_ sender: Any) {
    }
}
