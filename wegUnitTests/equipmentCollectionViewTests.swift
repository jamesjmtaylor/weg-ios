//
//  wegUnitTests.swift
//  wegUnitTests
//
//  Created by Taylor, James on 7/7/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import XCTest
@testable import weg_ios

class equipmentCollectionViewTests: XCTestCase {
    var vc : EquipmentCollectionViewController?
    
    override func setUp() {
        super.setUp()
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        vc = main.instantiateViewController(withIdentifier: "EquipmentCollectionViewController") as? EquipmentCollectionViewController
    }
    
    override func tearDown() {super.tearDown()}
    
    func testFrameShouldHoldTwoColumns() {
        let frame = CGRect(x: 0, y: 0, width: 375, height: 500)
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        let actual = EquipmentCollectionViewController.calculateNoOfColumns(cv: collectionView)
        let expected : CGFloat = 2.0
        XCTAssertEqual(actual, expected)
    }
    
    func testFrameShouldHoldSixColumns() {
        let frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        let actual = EquipmentCollectionViewController.calculateNoOfColumns(cv: collectionView)
        let expected : CGFloat = 6.0
        XCTAssertEqual(actual, expected)
    }
}
