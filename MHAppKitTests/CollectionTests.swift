//
//  CollectionTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation
import XCTest
@testable import MHAppKit

class CollectionTests: XCTestCase {
    
    func testSetInserting() {
        
        XCTAssertEqual(Set(["1", "C", "omg"]).inserting("gg"), Set(["1", "gg", "C", "omg"]))
        XCTAssertEqual(Set(["1", "C", "omg"]) + "gg", Set(["1", "gg", "C", "omg"]))
        XCTAssertEqual(Set(["1", "C", "omg"]) + ["gg", "ppp"], Set(["ppp", "1", "gg", "C", "omg"]))
    }
    
    func testSetRemoving() {
        
        XCTAssertEqual(Set(["1", "C", "omg", "gg"]).removing("gg"), Set(["1", "C", "omg"]))
        XCTAssertEqual(Set(["1", "C", "omg", "gg"]) - "gg", Set(["1", "C", "omg"]))
        XCTAssertEqual(Set(["1", "C", "omg", "gg"]) - ["gg", "omg"], Set(["1", "C"]))
    }
    
    func testArrayAppending() {
        
        XCTAssertEqual(["1", "C", "omg"].appending("gg"), ["1", "C", "omg", "gg"])
        XCTAssertEqual(["1", "C", "omg"].appending(contentsOf: ["gg", "pp"]), ["1", "C", "omg", "gg", "pp"])
        XCTAssertEqual(["1", "C", "omg"] + "gg", ["1", "C", "omg", "gg"])
        XCTAssertEqual(["1", "C", "omg"] + ["gg", "pp"], ["1", "C", "omg", "gg", "pp"])
    }
    
    func testArrayInserting() {
        
        XCTAssertEqual(["1", "C", "omg"].inserting("gg", at: 1), ["1", "gg", "C", "omg"])
        XCTAssertEqual(["1", "C", "omg"].inserting(contentsOf: ["gg", "pp"], at: 1), ["1", "gg", "pp", "C", "omg"])
    }
}
