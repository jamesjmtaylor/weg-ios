//
//  UIView+ActivityIndicator.swift
//  jenie
//
//  Created by Taylor, James on 4/2/18.
//  Copyright © 2018 James Taylor. All rights reserved.
//

import Foundation
import UIKit
import Lottie

extension UIView {
    func getAndStartActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame:
            CGRect.init(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        indicator.center = self.center
        self.addSubview(indicator)
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        return indicator
    }
}
