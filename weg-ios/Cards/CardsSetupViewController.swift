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
    private let repo = EquipmentRepository()
    private var equipment = [Equipment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(1,inComponent:0,animated:false)
        qtyStepper.stepValue = 5.0
        qtyStepper.minimumValue = 5.0
        qtyStepper.maximumValue = 100.0
        getEquipment()
    }
    var loadingView : LoadingView?
    func getEquipment(){
        let storedEquipment = EquipmentRepository.getEquipment { (error) in
            DispatchQueue.main.async {
                self.loadingView?.stopAnimation()
                if let errorString = error {
                    self.presentAlert(alert: errorString)
                }
                guard let equipment = EquipmentRepository.getEquipmentFromDatabase() else {return}
                self.equipment = equipment
            }
        }
        if let e = storedEquipment { equipment = e } else {
            loadingView = LoadingView.getAndStartLoadingView()
        }
    }
    // MARK: - Navigation
    let presentCardsSegue = "presentCardsSegue"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == presentCardsSegue {
            guard let navVc = segue.destination as? UINavigationController else {return}
            guard let vc = navVc.topViewController as? CardsViewController else {return}
            vc.deckSize = Int(qtyStepper.value)
            vc.difficulty = selectedDifficulty
            vc.selectedTypes = getSelectedTypes()
            vc.equipment = sortAndFilterEquipment(equipment: equipment)
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    // MARK: - PickerView
    @IBOutlet weak var difficultyPicker: UIPickerView!
    let difficultyChoices = [Difficulty.EASY,Difficulty.MEDIUM,Difficulty.HARD]
    var selectedDifficulty = Difficulty.MEDIUM
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return difficultyChoices.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficultyChoices[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDifficulty = difficultyChoices[row]
    }
    
    // MARK: - Buttons
    @IBOutlet weak var weaponsSwitch: UISwitch!
    @IBOutlet weak var landSwitch: UISwitch!
    @IBOutlet weak var seaSwitch: UISwitch!
    @IBOutlet weak var airSwitch: UISwitch!
    func getSelectedTypes() -> [EquipmentType] {
        var selectedTypes = [EquipmentType]()
        if weaponsSwitch.isOn {selectedTypes.append(EquipmentType.GUN)}
        if landSwitch.isOn {selectedTypes.append(EquipmentType.LAND)}
        if seaSwitch.isOn {selectedTypes.append(EquipmentType.SEA)}
        if airSwitch.isOn {selectedTypes.append(EquipmentType.AIR)}
        return selectedTypes
    }
    
    @IBOutlet weak var qtyLabel: UILabel!
    @IBAction func qtyStepperPressed(_ sender: UIStepper) {
        qtyLabel.text = Int(sender.value).description
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        if (equipment.count > 0){
            performSegue(withIdentifier: presentCardsSegue, sender: self)
        } else {
            self.presentAlert(alert: "No equipment available for flashcards.")
        }
    }
}
enum Difficulty: String {case EASY; case MEDIUM; case HARD}
