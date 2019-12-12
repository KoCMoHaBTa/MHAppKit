//
//  CGSizeScalingTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 10.09.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

#if !os(watchOS)
import Foundation
import XCTest
@testable import MHAppKit

class CGSizeScalingTests: XCTestCase {
    
    func testCGSizeScalingToFit() {
        
        //wide into wide
        XCTAssertEqual(CGSize(width: 200, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 80, height: 20))
        XCTAssertEqual(CGSize(width: 100, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 40, height: 20))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 20, height: 20))
        
        XCTAssertEqual(CGSize(width: 200, height: 20).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 10))
        XCTAssertEqual(CGSize(width: 100, height: 20).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 20))
        XCTAssertEqual(CGSize(width: 50, height: 20).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 50, height: 20))
        
        XCTAssertEqual(CGSize(width: 200, height: 10).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 5))
        XCTAssertEqual(CGSize(width: 100, height: 10).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 10))
        XCTAssertEqual(CGSize(width: 50, height: 10).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 20))
        
        //tall into wide
        XCTAssertEqual(CGSize(width: 50, height: 200).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 5, height: 20))
        XCTAssertEqual(CGSize(width: 50, height: 100).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 10, height: 20))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 20, height: 20))
        
        XCTAssertEqual(CGSize(width: 20, height: 200).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 2, height: 20))
        XCTAssertEqual(CGSize(width: 20, height: 100).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 4, height: 20))
        XCTAssertEqual(CGSize(width: 20, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 8, height: 20))
        
        XCTAssertEqual(CGSize(width: 10, height: 200).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 1, height: 20))
        XCTAssertEqual(CGSize(width: 10, height: 100).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 2, height: 20))
        XCTAssertEqual(CGSize(width: 10, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 4, height: 20))
        
        //square into wide
        XCTAssertEqual(CGSize(width: 200, height: 200).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 20, height: 20))
        XCTAssertEqual(CGSize(width: 100, height: 100).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 20, height: 20))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 20, height: 20))
        XCTAssertEqual(CGSize(width: 20, height: 20).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 20, height: 20))
        XCTAssertEqual(CGSize(width: 10, height: 10).scaling(to: .fit, into: CGSize(width: 100, height: 20)), CGSize(width: 20, height: 20))
        
        //tall into tall
        XCTAssertEqual(CGSize(width: 50, height: 200).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 80))
        XCTAssertEqual(CGSize(width: 50, height: 100).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 40))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 20))
        
        XCTAssertEqual(CGSize(width: 20, height: 200).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 10, height: 100))
        XCTAssertEqual(CGSize(width: 20, height: 100).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 100))
        XCTAssertEqual(CGSize(width: 20, height: 50).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 50))
        
        XCTAssertEqual(CGSize(width: 10, height: 200).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 5, height: 100))
        XCTAssertEqual(CGSize(width: 10, height: 100).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 10, height: 100))
        XCTAssertEqual(CGSize(width: 10, height: 50).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 100))
        
        //wide into tall
        XCTAssertEqual(CGSize(width: 200, height: 50).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 5))
        XCTAssertEqual(CGSize(width: 100, height: 50).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 10))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 20))
        
        XCTAssertEqual(CGSize(width: 200, height: 20).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 2))
        XCTAssertEqual(CGSize(width: 100, height: 20).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 4))
        XCTAssertEqual(CGSize(width: 50, height: 20).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 8))
        
        XCTAssertEqual(CGSize(width: 200, height: 10).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 1))
        XCTAssertEqual(CGSize(width: 100, height: 10).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 2))
        XCTAssertEqual(CGSize(width: 50, height: 10).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 4))
        
        //square into tall
        XCTAssertEqual(CGSize(width: 200, height: 200).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 20))
        XCTAssertEqual(CGSize(width: 100, height: 100).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 20))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 20))
        XCTAssertEqual(CGSize(width: 20, height: 20).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 20))
        XCTAssertEqual(CGSize(width: 10, height: 10).scaling(to: .fit, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 20))
        
        //wide into square
        XCTAssertEqual(CGSize(width: 200, height: 150).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 75))
        XCTAssertEqual(CGSize(width: 200, height: 100).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 50))
        XCTAssertEqual(CGSize(width: 200, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 25))
        
        XCTAssertEqual(CGSize(width: 100, height: 200).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 50, height: 100))
        XCTAssertEqual(CGSize(width: 100, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 50))
        
        XCTAssertEqual(CGSize(width: 50, height: 200).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 25, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 100).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 50, height: 100))
        
        //tall into square
        XCTAssertEqual(CGSize(width: 150, height: 200).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 75, height: 100))
        XCTAssertEqual(CGSize(width: 100, height: 200).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 50, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 200).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 25, height: 100))
        
        XCTAssertEqual(CGSize(width: 200, height: 100).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 50))
        XCTAssertEqual(CGSize(width: 50, height: 100).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 50, height: 100))
        
        XCTAssertEqual(CGSize(width: 200, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 25))
        XCTAssertEqual(CGSize(width: 100, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 50))
        
        //square into square
        XCTAssertEqual(CGSize(width: 200, height: 200).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 100, height: 100).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fit, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 100))
    }
    
    func testCGSizeScalingToFill() {
        
        //wide into wide
        XCTAssertEqual(CGSize(width: 200, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 25))
        XCTAssertEqual(CGSize(width: 100, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 50))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 100))
        
        XCTAssertEqual(CGSize(width: 200, height: 20).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 200, height: 20))
        XCTAssertEqual(CGSize(width: 100, height: 20).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 20))
        XCTAssertEqual(CGSize(width: 50, height: 20).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 40))
        
        XCTAssertEqual(CGSize(width: 200, height: 10).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 400, height: 20))
        XCTAssertEqual(CGSize(width: 100, height: 10).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 200, height: 20))
        XCTAssertEqual(CGSize(width: 50, height: 10).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 20))
        
        //tall into wide
        XCTAssertEqual(CGSize(width: 50, height: 200).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 400))
        XCTAssertEqual(CGSize(width: 50, height: 100).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 200))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 100))
        
        XCTAssertEqual(CGSize(width: 20, height: 200).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 1000))
        XCTAssertEqual(CGSize(width: 20, height: 100).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 500))
        XCTAssertEqual(CGSize(width: 20, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 250))
        
        XCTAssertEqual(CGSize(width: 10, height: 200).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 2000))
        XCTAssertEqual(CGSize(width: 10, height: 100).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 1000))
        XCTAssertEqual(CGSize(width: 10, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 500))
        
        //square into wide
        XCTAssertEqual(CGSize(width: 200, height: 200).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 100, height: 100).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 20, height: 20).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 10, height: 10).scaling(to: .fill, into: CGSize(width: 100, height: 20)), CGSize(width: 100, height: 100))
        
        //tall into tall
        XCTAssertEqual(CGSize(width: 50, height: 200).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 25, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 100).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 50, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 100, height: 100))
        
        XCTAssertEqual(CGSize(width: 20, height: 200).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 200))
        XCTAssertEqual(CGSize(width: 20, height: 100).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 100))
        XCTAssertEqual(CGSize(width: 20, height: 50).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 40, height: 100))
        
        XCTAssertEqual(CGSize(width: 10, height: 200).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 400))
        XCTAssertEqual(CGSize(width: 10, height: 100).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 200))
        XCTAssertEqual(CGSize(width: 10, height: 50).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 20, height: 100))
        
        //wide into tall
        XCTAssertEqual(CGSize(width: 200, height: 50).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 400, height: 100))
        XCTAssertEqual(CGSize(width: 100, height: 50).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 200, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 100, height: 100))
        
        XCTAssertEqual(CGSize(width: 200, height: 20).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 1000, height: 100))
        XCTAssertEqual(CGSize(width: 100, height: 20).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 500, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 20).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 250, height: 100))
        
        XCTAssertEqual(CGSize(width: 200, height: 10).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 2000, height: 100))
        XCTAssertEqual(CGSize(width: 100, height: 10).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 1000, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 10).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 500, height: 100))
        
        //square into tall
        XCTAssertEqual(CGSize(width: 200, height: 200).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 100, height: 100).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 20, height: 20).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 10, height: 10).scaling(to: .fill, into: CGSize(width: 20, height: 100)), CGSize(width: 100, height: 100))
        
        //wide into square
        XCTAssertEqual(CGSize(width: 210, height: 150).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 140, height: 100))
        XCTAssertEqual(CGSize(width: 200, height: 100).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 200, height: 100))
        XCTAssertEqual(CGSize(width: 200, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 400, height: 100))
        
        XCTAssertEqual(CGSize(width: 100, height: 200).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 200))
        XCTAssertEqual(CGSize(width: 100, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 200, height: 100))
        
        XCTAssertEqual(CGSize(width: 50, height: 200).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 400))
        XCTAssertEqual(CGSize(width: 50, height: 100).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 200))
        
        //tall into square
        XCTAssertEqual(CGSize(width: 150, height: 210).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 140))
        XCTAssertEqual(CGSize(width: 100, height: 200).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 200))
        XCTAssertEqual(CGSize(width: 50, height: 200).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 400))
        
        XCTAssertEqual(CGSize(width: 200, height: 100).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 200, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 100).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 200))
        
        XCTAssertEqual(CGSize(width: 200, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 400, height: 100))
        XCTAssertEqual(CGSize(width: 100, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 200, height: 100))
        
        //square into square
        XCTAssertEqual(CGSize(width: 200, height: 200).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 100, height: 100).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 100))
        XCTAssertEqual(CGSize(width: 50, height: 50).scaling(to: .fill, into: CGSize(width: 100, height: 100)), CGSize(width: 100, height: 100))
    }
}
#endif
