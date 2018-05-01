//
//  UIViewController+PresentAlert.swift
//  jenie
//
//  Created by Taylor, James on 4/2/18.
//  Copyright © 2018 James Taylor. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(alert : String) {
        let alert = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Try again", style: .default, handler: nil)
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
}
