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
    func addAttributes(isBolded: Bool = false, isUnderlined: Bool = false){
        var attrs = [NSAttributedString.Key:Any]()
        let underline = [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        let bold = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        if isBolded {attrs[bold.keys.first!] = (bold.values.first!)}
        if isUnderlined {attrs[underline.keys.first!] = (underline.values.first!)}
        let attributedString = NSMutableAttributedString(string: self.text ?? "",
                                                         attributes: attrs)
        self.attributedText = attributedString
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
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

