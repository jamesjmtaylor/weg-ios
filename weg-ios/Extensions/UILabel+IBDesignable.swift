//
//  UILabel+IBDesignable.swift
//  weg-ios
//
//  Created by Taylor, James on 4/29/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UILabel {
    @IBInspectable
    public var padding:CGFloat {
        set{
//            let rect = self.frame
//            let insets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
            self.frame.insetBy(dx: padding, dy: padding)
//            super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
//            if let currentAttibutedText = self.attributedText {
//                let attribString = NSMutableAttributedString(attributedString: currentAttibutedText)
//                attribString.addAttributes([NSAttributedStringKey.kern:newValue], range:NSMakeRange(0, currentAttibutedText.length))
//                self.attributedText = attribString
//            }
        } get {
            return self.alignmentRectInsets.bottom
        }
    }
    @IBInspectable
    public var kerning:CGFloat {
        set{
            if let currentAttibutedText = self.attributedText {
                let attribString = NSMutableAttributedString(attributedString: currentAttibutedText)
                attribString.addAttributes([NSAttributedStringKey.kern:newValue], range:NSMakeRange(0, currentAttibutedText.length))
                self.attributedText = attribString
            }
        } get {
            var kerning:CGFloat = 0
            if let attributedText = self.attributedText {
                attributedText.enumerateAttribute(NSAttributedStringKey.kern,
                                                  in: NSMakeRange(0, attributedText.length),
                                                  options: .init(rawValue: 0)) { (value, range, stop) in
                                                    kerning = value as? CGFloat ?? 0
                }
            }
            return kerning
        }
    }
}
