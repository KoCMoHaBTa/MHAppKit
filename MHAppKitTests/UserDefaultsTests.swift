//
//  UserDefaultsTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

#if !os(watchOS)
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
    
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
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
    
    func testPropertyWraper() {
        
        class Mock {
            
            struct Keys {
                
                static let k1: String = .uuid
                static let k2: String = .uuid
                static let k3: String = .uuid
            }
            
            @UserDefaultsStored(key: Keys.k1) var v1: Int = 5
            @UserDefaultsStored(key: Keys.k2) var v2: Int? = 10
            @UserDefaultsStored(key: Keys.k3) var v3: Int? = nil
        }
        
        let mock = Mock()
        
        var lastV1: Int? = nil
        var o1: Any? = mock.$v1.observeChanges { (value) in
            
            lastV1 = value
        }
        
        var lastV2: Int? = nil
        var o2: Any? = mock.$v2.observeChanges { (value) in
            
            lastV2 = value
        }
        
        var lastV3: Int? = nil
        var o3: Any? = mock.$v3.observeChanges { (value) in
            
            lastV3 = value
        }
        
        XCTAssertEqual(mock.v1, 5)
        XCTAssertEqual(mock.v2, 10)
        XCTAssertNil(mock.v3)
        
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k1), 5)
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k2), 10)
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k3), 0)
        
        XCTAssertNil(lastV1)
        XCTAssertNil(lastV2)
        XCTAssertNil(lastV3)
        
        mock.v1 = 7
        mock.v2 = nil
        mock.v3 = 20
        
        XCTAssertEqual(mock.v1, 7)
        XCTAssertNil(mock.v2)
        XCTAssertEqual(mock.v3, 20)
        
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k1), 7)
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k2), 0)
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k3), 20)
        
        XCTAssertEqual(lastV1, 7)
        XCTAssertNil(lastV2)
        XCTAssertEqual(lastV3, 20)
        
        
        _ = o1
        _ = o2
        _ = o3
        o1 = nil
        o2 = nil
        o3 = nil
    }
    
    func testPropertyWraperWithWrongValueTypes() {

        class Mock {
            
            struct Keys {
                
                static let k1: String = .uuid
                static let k2: String = .uuid
                static let k3: String = .uuid
            }
            
            @UserDefaultsStored(key: Keys.k1) var v1: Int = 5
            @UserDefaultsStored(key: Keys.k2) var v2: Int? = 10
            @UserDefaultsStored(key: Keys.k3) var v3: Int? = nil
        }
        
        //set initial values of wrong type
        UserDefaults.standard.set("asd", forKey: Mock.Keys.k1)
        UserDefaults.standard.set("wer", forKey: Mock.Keys.k2)
        UserDefaults.standard.set("sfgd", forKey: Mock.Keys.k3)
        UserDefaults.standard.synchronize()
        
        let mock = Mock()
        
        var lastV1: Int? = nil
        var o1: Any? = mock.$v1.observeChanges { (value) in
            
            lastV1 = value
        }
        
        var lastV2: Int? = nil
        var o2: Any? = mock.$v2.observeChanges { (value) in
            
            lastV2 = value
        }
        
        var lastV3: Int? = nil
        var o3: Any? = mock.$v3.observeChanges { (value) in
            
            lastV3 = value
        }
        
        XCTAssertEqual(mock.v1, 5)
        XCTAssertEqual(mock.v2, 10)
        XCTAssertNil(mock.v3)
        
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k1), 5)
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k2), 10)
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k3), 0)
        
        XCTAssertNil(lastV1)
        XCTAssertNil(lastV2)
        XCTAssertNil(lastV3)
        
        mock.v1 = 7
        mock.v2 = nil
        mock.v3 = 20
        
        XCTAssertEqual(mock.v1, 7)
        XCTAssertNil(mock.v2)
        XCTAssertEqual(mock.v3, 20)
        
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k1), 7)
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k2), 0)
        XCTAssertEqual(UserDefaults.standard.integer(forKey: Mock.Keys.k3), 20)
        
        XCTAssertEqual(lastV1, 7)
        XCTAssertNil(lastV2)
        XCTAssertEqual(lastV3, 20)
        
        
        _ = o1
        _ = o2
        _ = o3
        o1 = nil
        o2 = nil
        o3 = nil
    }
}
#endif
