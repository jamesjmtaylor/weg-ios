//
//  repoUnitTests.swift
//  wegUnitTests
//
//  Created by Taylor, James on 10/2/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import XCTest
import Mockingjay
@testable import weg_ios

class repoUnitTests: XCTestCase {

    override func setUp() {
        super.setUp()
        let url = Bundle(for: type(of: self)).url(forResource: "getAllResponse", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let getAllUrl = EquipmentRepository.getAllUrl()
//        stub(http(.get, uri: getAllUrl), jsonData(data))
    }

    func testExample() {
        EquipmentRepository.getEquipment { (error) in
            if let error = error {
                XCTFail(error)
            }
            let equipment = EquipmentRepository.getEquipmentFromDatabase()
            XCTAssert(!(equipment?.isEmpty ?? true)) //Should not be empty
        }
    }
}
