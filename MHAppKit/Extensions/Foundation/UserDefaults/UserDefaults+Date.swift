//
//  UserDefaults+Date.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/17/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    /**
     Returns the date value associated with the specified key using given date formatter.
     - parameter defaultName: A key in the current user‘s defaults database.
     - returns: The date associated with the specified key, or nil if the key was not found or the value cannot be formatted.
     */
    
    public func date(forKey defaultName: String, using formatter: DateFormatter) -> Date? {
        
        guard let string = self.string(forKey: defaultName) else {
            
            return nil
        }
        
        let value = formatter.date(from: string)
        return value
    }
    
    /**
     Sets the date value of the specified default key using a given date formatter.
     - parameter value: The date value to store in the defaults database.
     - parameter defaultName: The key with which to associate the value.
     - parameter formatter: The formatter used to parse the stored date value.
     */
    public func set(_ value: Date?, forKey defaultName: String, using formatter: DateFormatter) {
        
        var string: String? = nil
        
        if let date = value {
            
            string = formatter.string(from: date)
        }
        
        self.set(string, forKey: defaultName)
    }
    
    /**
     Returns the date value associated with the specified key using ISO8601 date formatter.
     - parameter defaultName: A key in the current user‘s defaults database.
     - returns: The date associated with the specified key, or nil if the key was not found or the value cannot be formatted.
     */
    
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    public func date(forKey defaultName: String, using formatter: ISO8601DateFormatter) -> Date? {
        
        guard let string = self.string(forKey: defaultName) else {
            
            return nil
        }
        
        let value = formatter.date(from: string)
        return value
    }
    
    /**
     Sets the date value of the specified default key using ISO8601 date formatter.
     - parameter value: The date value to store in the defaults database.
     - parameter defaultName: The key with which to associate the value.
     - parameter formatter: The formatter used to parse the stored date value.
     */
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
    public func set(_ value: Date?, forKey defaultName: String, using formatter: ISO8601DateFormatter) {
        
        var string: String? = nil
        
        if let date = value {
            
            string = formatter.string(from: date)
        }
        
        self.set(string, forKey: defaultName)
    }
}

