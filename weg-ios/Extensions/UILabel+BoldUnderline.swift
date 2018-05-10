//
//  UILabel+BoldUnderline.swift
//  weg-ios
//
//  Created by Taylor, James on 5/10/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedStringKey.underlineStyle,
                                          value: NSUnderlineStyle.styleSingle.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
    func bold() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString).bold(textString)
            self.attributedText = attributedString
        }
    }
}

extension UIButton {
    func underline() {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle,
                                      value: NSUnderlineStyle.styleSingle.rawValue,
                                      range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: 12)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}

