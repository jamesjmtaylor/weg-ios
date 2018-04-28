//
//  UIColor+AppColors.swift
//  weg-ios
//
//  Created by Taylor, James on 4/28/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func clear() -> UIColor {return UIColor.init(hex: "00000000")}
    static func sixtyAlpa() -> UIColor {return UIColor.init(hex: "99000000")}
    static func fiftyAlpa() -> UIColor {return UIColor.init(hex: "80000000")}
    static func fortyAlpa() -> UIColor {return UIColor.init(hex: "66000000")}
    static func colorPrimary() -> UIColor {return UIColor.init(hex: "FF000000")}
    static func colorPrimaryDark() -> UIColor {return UIColor.init(hex: "FF000000")}
    static func colorAccent() -> UIColor {return UIColor.init(hex: "FFFF0000")}
    static func gray() -> UIColor {return UIColor.init(hex: "FFAAAAAA")}
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        let a = (rgbValue & 0xff000000) >> 24
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff,
            alpha: CGFloat(a) / 0xff
        )
    }
}
