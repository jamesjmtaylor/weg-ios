//
//  Array+Shuffle.swift
//  weg-ios
//
//  Created by Taylor, James on 5/19/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle(){
        var last = self.count - 1
        while last > 0 {
            let rand = Int(arc4random_uniform(UInt32(last)))
            self.swapAt(last, rand)
            last -= 1
        }
    }
}
