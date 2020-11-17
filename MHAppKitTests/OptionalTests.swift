//
//  OptionalTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

#if !os(watchOS)
import Foundation
import XCTest
@testable import MHAppKit

class OptionalTests: XCTestCase {
    
    func testOptionalType() {
        
        func generic<T: OptionalType>(_ value: T) -> T.Wrapped? {
            
            return value.wrapped
        }
        
        let noneValue: Int? = nil
        let someValue: Int? = 5
        
        XCTAssertNil(Optional.none.wrapped)
        XCTAssertNotNil(Optional.some(1).wrapped)
        XCTAssertEqual(Optional.some(1).wrapped, 1)
        
        XCTAssertNil(generic(Optional.none))
        XCTAssertNotNil(generic(Optional.some(5)))
        
        XCTAssertNil(generic(noneValue))
        XCTAssertNotNil(generic(someValue))
        XCTAssertEqual(generic(someValue), 5)
    }
    
    func testOptionalTypeVerifiable() {
        
        func generic<T: OptionalTypeVerifiable>(_ value: T) -> Bool {
            
            return value.isNil
        }
        
        func typeCast<T>(_ value: T) -> Bool? {
            
            return (value as? OptionalTypeVerifiable)?.isNil
        }
        
        let noneValue: Int? = nil
        let someValue: Int? = 5
        let notOptional: Int = 10
        
        XCTAssertTrue(Optional<Int>.none.isNil)
        XCTAssertFalse(Optional.some(1).isNil)
        
        XCTAssertTrue(noneValue.isNil)
        XCTAssertFalse(someValue.isNil)
        
        XCTAssertTrue(generic(Optional<Int>.none))
        XCTAssertFalse(generic(Optional.some(1)))
        XCTAssertTrue(generic(noneValue))
        XCTAssertFalse(generic(someValue))
        
        try XCTAssertTrue(XCTUnwrap(typeCast(Optional<Int>.none)))
        try XCTAssertFalse(XCTUnwrap(typeCast(Optional.some(1))))
        try XCTAssertTrue(XCTUnwrap(typeCast(noneValue)))
        try XCTAssertFalse(XCTUnwrap(typeCast(someValue)))
        
        XCTAssertNil(typeCast(notOptional))
    }
}
#endif
