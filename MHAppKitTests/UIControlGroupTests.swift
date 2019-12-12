//
//  UIControlRadioGroupTests.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/25/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import XCTest
@testable import MHAppKit

class UIControlGroupTests: XCTestCase {
    
    func testUIControlRadioGroup_MSNO_NSNO() {
        
        let group = UIControlGroup()
        group.controls = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
        group.selectAllControl = UIButton()
        group.deselectAllControl = UIButton()
        
        XCTAssertEqual(group.controls.count, 5)
        XCTAssertEqual(group.selectedControlIndexes, [])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3, 4])
        
        group.allowMultipleSelection = false
        group.allowNoneSelection = false
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.toggleControl(at: 3)
        XCTAssertEqual(group.selectedControlIndexes, [3])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 4])
        
        group.toggleControl(at: 4)
        XCTAssertEqual(group.selectedControlIndexes, [4])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3])
        
        group.toggleControl(at: 4)
        XCTAssertEqual(group.selectedControlIndexes, [4])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3])
        
        group.toggleControl(at: 3)
        XCTAssertEqual(group.selectedControlIndexes, [3])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 4])
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.selectAllControls()
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.deselectAllControls()
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
    }
    
    func testUIControlRadioGroup_MSYES_NSNO() {
        
        let group = UIControlGroup()
        group.controls = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
        group.selectAllControl = UIButton()
        group.deselectAllControl = UIButton()
        
        XCTAssertEqual(group.controls.count, 5)
        XCTAssertEqual(group.selectedControlIndexes, [])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3, 4])
        
        group.allowMultipleSelection = true
        group.allowNoneSelection = false
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.toggleControl(at: 3)
        XCTAssertEqual(group.selectedControlIndexes, [1, 3])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 4])
        
        group.toggleControl(at: 4)
        XCTAssertEqual(group.selectedControlIndexes, [1, 3, 4])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2])
        
        group.toggleControl(at: 4)
        XCTAssertEqual(group.selectedControlIndexes, [1, 3])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 4])
        
        group.toggleControl(at: 3)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.selectAllControls()
        XCTAssertEqual(group.selectedControlIndexes, [0, 1, 2, 3, 4])
        XCTAssertEqual(group.deselectedControlIndexes, [])
        
        group.deselectAllControls()
        XCTAssertEqual(group.selectedControlIndexes, [0, 1, 2, 3, 4])
        XCTAssertEqual(group.deselectedControlIndexes, [])
    }
    
    func testUIControlRadioGroup_MSNO_NSYES() {
        
        let group = UIControlGroup()
        group.controls = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
        group.selectAllControl = UIButton()
        group.deselectAllControl = UIButton()
        
        XCTAssertEqual(group.controls.count, 5)
        XCTAssertEqual(group.selectedControlIndexes, [])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3, 4])
        
        group.allowMultipleSelection = false
        group.allowNoneSelection = true
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.toggleControl(at: 3)
        XCTAssertEqual(group.selectedControlIndexes, [3])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 4])
        
        group.toggleControl(at: 4)
        XCTAssertEqual(group.selectedControlIndexes, [4])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3])
        
        group.toggleControl(at: 4)
        XCTAssertEqual(group.selectedControlIndexes, [])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3, 4])
        
        group.toggleControl(at: 3)
        XCTAssertEqual(group.selectedControlIndexes, [3])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 4])
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3, 4])
        
        group.selectAllControls()
        XCTAssertEqual(group.selectedControlIndexes, [])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3, 4])
        
        group.deselectAllControls()
        XCTAssertEqual(group.selectedControlIndexes, [])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3, 4])
    }
    
    func testUIControlRadioGroup_MSYES_NSYES() {
        
        let group = UIControlGroup()
        group.controls = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
        group.selectAllControl = UIButton()
        group.deselectAllControl = UIButton()
        
        XCTAssertEqual(group.controls.count, 5)
        XCTAssertEqual(group.selectedControlIndexes, [])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3, 4])
        
        group.allowMultipleSelection = true
        group.allowNoneSelection = true
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.toggleControl(at: 3)
        XCTAssertEqual(group.selectedControlIndexes, [1, 3])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 4])
        
        group.toggleControl(at: 4)
        XCTAssertEqual(group.selectedControlIndexes, [1, 3, 4])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2])
        
        group.toggleControl(at: 4)
        XCTAssertEqual(group.selectedControlIndexes, [1, 3])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 4])
        
        group.toggleControl(at: 3)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3, 4])
        
        group.toggleControl(at: 1)
        XCTAssertEqual(group.selectedControlIndexes, [1])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 2, 3, 4])
        
        group.selectAllControls()
        XCTAssertEqual(group.selectedControlIndexes, [0, 1, 2, 3, 4])
        XCTAssertEqual(group.deselectedControlIndexes, [])
        
        group.deselectAllControls()
        XCTAssertEqual(group.selectedControlIndexes, [])
        XCTAssertEqual(group.deselectedControlIndexes, [0, 1, 2, 3, 4])
    }
}
#endif
