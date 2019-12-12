//
//  StringTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 10.09.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

#if !os(watchOS)
import Foundation
import XCTest
@testable import MHAppKit

class StringTests: XCTestCase {
    
    func testSubstringRangesLookup() {
        
        let string = "The dog is a dog"
        let expectedRange1 = string.index(string.startIndex, offsetBy: 4)..<string.index(string.startIndex, offsetBy: 7)
        let expectedRange2 = string.index(string.startIndex, offsetBy: 13)..<string.index(string.startIndex, offsetBy: 16)
        
        let result = "The dog is a dog".ranges(of: "dog")
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result, [expectedRange1, expectedRange2])
    }

    func testOptionalConcatenation() {
        
        let a: String = "a"
        let b: Substring = "b"
        let ao: String? = "ao"
        let bo: Substring? = "bo"
        let stringNil: String? = nil
        let substringNil: Substring? = nil
        
        XCTAssertEqual(a + b, "ab")
        XCTAssertEqual(a + ao, "aao")
        XCTAssertEqual(a + bo, "abo")
        XCTAssertEqual(a + stringNil, "a")
        XCTAssertEqual(a + substringNil, "a")
        
        XCTAssertEqual(b + a, "ba")
        XCTAssertEqual(b + ao, "bao")
        XCTAssertEqual(b + bo, "bbo")
        XCTAssertEqual(b + stringNil, "b")
        XCTAssertEqual(b + substringNil, "b")
    }
    
    func testNilEmpty() {
        
        XCTAssertNil("".nonEmpty)
        XCTAssertNotNil(" ".nonEmpty)
        XCTAssertNotNil("a".nonEmpty)
        
        XCTAssertNil("".nonEmptyTrimmed)
        XCTAssertNil(" ".nonEmptyTrimmed)
        XCTAssertNotNil("a".nonEmptyTrimmed)
        XCTAssertEqual(" a ".nonEmptyTrimmed, "a")
        
        XCTAssertEqual("".trimmingWhitespacesAndNewlines, "")
        XCTAssertEqual(" ".trimmingWhitespacesAndNewlines, "")
        XCTAssertEqual("a".trimmingWhitespacesAndNewlines, "a")
        XCTAssertEqual(" a ".trimmingWhitespacesAndNewlines, "a")
    }
}
#endif
