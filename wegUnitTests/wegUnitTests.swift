//
//  wegUnitTests.swift
//  wegUnitTests
//
//  Created by Taylor, James on 7/7/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import XCTest

class wegUnitTests: XCTestCase {
    var vc : EquipmentCollectionViewController?
    
    override func setUp() {
        super.setUp()
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        vc = main.instantiateViewController(withIdentifier: "EquipmentCollectionViewController") as? EquipmentCollectionViewController
    }
    
    override func tearDown() {super.tearDown()}
    
    func testExample() {
        let frame = CGRect(x: 0, y: 0, width: 375, height: 500)
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        let actual = EquipmentCollectionViewController.calculateNoOfColumns(cv: collectionView)
        let expected : CGFloat = 2.0
        XCTAssertEqual(actual, expected)
    }
    
    func testPerformanceExample() {
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
