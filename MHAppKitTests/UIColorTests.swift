//
//  UIColorTests.swift
//  MHAppKit
//
//  Created by Milen Halachev on 6/10/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import XCTest
@testable import MHAppKit

class UIColorTests: XCTestCase {
    
    func testInit() {
        
        //RGB compoennts
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1), UIColor(R: 255, G: 0, B: 0, alpha: 1))
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.5), UIColor(R: 0, G: 255, B: 0, alpha: 0.5))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0), UIColor(R: 0, G: 0, B: 255, alpha: 0))
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(R: 255, G: 255, B: 255, alpha: 1))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 0, alpha: 1), UIColor(R: 0, G: 0, B: 0))
        
        //RGB Number
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1), UIColor(RGB: 0xFF0000, alpha: 1))
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.5), UIColor(RGB: 0x00FF00, alpha: 0.5))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0), UIColor(RGB: 0x0000FF, alpha: 0))
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(RGB: 0xFFFFFF, alpha: 1))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 0, alpha: 1), UIColor(RGB: 0x000000))
        
        //RGB HEX String
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1), UIColor(HEX: "FF0000", alpha: 1))
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.5), UIColor(HEX: "00FF00", alpha: 0.5))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0), UIColor(HEX: "0000FF", alpha: 0))
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(HEX: "FFFFFF", alpha: 1))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 0, alpha: 1), UIColor(HEX: "000000"))
        
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(RGB: 16777215))
        
        //lower case HEX string
        XCTAssertEqual(UIColor(R: 200, G: 199, B: 204), UIColor(HEX: "c8c7cc"))
        
        //test hash tagged hex strings
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0), UIColor(HEX: "#0000FF", alpha: 0))
        XCTAssertEqual(UIColor(R: 200, G: 199, B: 204), UIColor(HEX: "#c8c7cc"))
    }
    
    func testHEX() {
        
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 0.34).HEX, "FFFFFF")
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 0.34).HEX()?.alpha, 0.34)
        
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1).HEX, "FF0000")
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1).HEX()?.alpha, 1)
        
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.5).HEX, "00FF00")
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.5).HEX()?.alpha, 0.5)
        
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0).HEX, "0000FF")
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0).HEX()?.alpha, 0)
    }
    
    func testErrors() {
        
        XCTAssertNil(UIColor(HEX: "this should fail"))
        XCTAssertNil(UIColor(RGB: 16777216))
    }
}
