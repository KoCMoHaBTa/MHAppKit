//
//  UserDefaultsTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation
import XCTest
@testable import MHAppKit

class UserDefaultsTests: XCTestCase {
    
    func testStoringDate() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let date = formatter.date(from: "19.05.1990")
        let key: String = .uuid
        
        UserDefaults.standard.set(date, forKey: key, using: formatter)
        UserDefaults.standard.synchronize()
        
        try XCTAssertEqual(XCTUnwrap(UserDefaults.standard.date(forKey: key, using: formatter)), date)
    }
    
    @available(iOS 10.0, *)
    func testStoringISO8601Date() {
        
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: "2020-02-19T19:30:00Z")
        let key: String = .uuid
        
        UserDefaults.standard.set(date, forKey: key, using: formatter)
        UserDefaults.standard.synchronize()
        
        try XCTAssertEqual(XCTUnwrap(UserDefaults.standard.date(forKey: key, using: formatter)), date)
    }
    
    func testObserver() {
        
        let key: String = .uuid
        var lastValue: Int? = nil
        
        var observer: Any? = UserDefaults.standard.observeChanges(forKey: key) { (value: Int?) in
            
            lastValue = value
        }
        
        XCTAssertNil(lastValue)
        
        UserDefaults.standard.set(5, forKey: key)
        UserDefaults.standard.synchronize()
        XCTAssertEqual(lastValue, 5)
        
        UserDefaults.standard.set("asd", forKey: key)
        UserDefaults.standard.synchronize()
        XCTAssertNil(lastValue)
        
        UserDefaults.standard.set(6, forKey: key)
        UserDefaults.standard.synchronize()
        XCTAssertEqual(lastValue, 6)
        
        UserDefaults.standard.set(nil, forKey: key)
        UserDefaults.standard.synchronize()
        XCTAssertNil(lastValue)
        
        _ = observer
        observer = nil
    }
}
