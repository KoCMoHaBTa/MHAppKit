//
//  UIColorTests.swift
//  MHAppKit
//
//  Created by Milen Halachev on 6/10/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
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
        
        //RGBA Number
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1), UIColor(RGBA: 0xFF0000FF))
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.4), UIColor(RGBA: 0x00FF0066))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0), UIColor(RGBA: 0x0000FF00))
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(RGBA: 0xFFFFFFFF))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 0, alpha: 1), UIColor(RGBA: 0x000000FF))
        
        //ARGB Number
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1), UIColor(ARGB: 0xFFFF0000))
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.4), UIColor(ARGB: 0x6600FF00))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0), UIColor(ARGB: 0x000000FF))
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(ARGB: 0xFFFFFFFF))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 0, alpha: 1), UIColor(ARGB: 0xFF000000))
        
        //RGB HEX String
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1), UIColor(RGB: "FF0000", alpha: 1))
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.5), UIColor(RGB: "00FF00", alpha: 0.5))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0), UIColor(RGB: "#0000FF", alpha: 0))
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(RGB: "#FFFFFF", alpha: 1))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 0, alpha: 1), UIColor(RGB: "000000"))
        
        //RGBA HEX String
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1), UIColor(RGBA: "FF0000FF"))
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.4), UIColor(RGBA: "00FF0066"))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0), UIColor(RGBA: "#0000FF00"))
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(RGBA: "#FFFFFFFF"))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 0, alpha: 1), UIColor(RGBA: "000000FF"))
        
        //ARGB HEX String
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1), UIColor(ARGB: "FFFF0000"))
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.4), UIColor(ARGB: "6600FF00"))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0), UIColor(ARGB: "#000000FF"))
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(ARGB: "#FFFFFFFF"))
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 0, alpha: 1), UIColor(ARGB: "FF000000"))
        
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(RGB: 16777215))
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(RGBA: UInt32.max))
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(ARGB: 4294967295))
        
        //lower case HEX string
        XCTAssertEqual(UIColor(R: 200, G: 199, B: 204), UIColor(RGB: "c8c7cc"))
        
        //test hash tagged hex strings
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0), UIColor(RGB: "#0000FF", alpha: 0))
        XCTAssertEqual(UIColor(R: 200, G: 199, B: 204), UIColor(RGB: "#c8c7cc"))
    }
    
    func testHEX() {
        
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 0.34).RGB, "#FFFFFF")
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 0.34).HEX()?.alpha, 0.34)
        
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1).HEX(includeHashtag: true)?.HEX, "#FF0000")
        XCTAssertEqual(UIColor(red: 1, green: 0, blue: 0, alpha: 1).HEX()?.alpha, 1)
        
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.5).HEX(includeHashtag: false)?.HEX, "00FF00")
        XCTAssertEqual(UIColor(red: 0, green: 1, blue: 0, alpha: 0.5).HEX()?.alpha, 0.5)
        
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0).RGB, "#0000FF")
        XCTAssertEqual(UIColor(red: 0, green: 0, blue: 1, alpha: 0).HEX()?.alpha, 0)
        
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).RGBA, "#FFFFFF66")
        XCTAssertEqual(UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).ARGB, "#66FFFFFF")
    }
    
    func testErrors() {
        
        XCTAssertNil(UIColor(RGB: "this should fail"))
        XCTAssertNil(UIColor(RGB: 16777216))
    }
}
#endif
