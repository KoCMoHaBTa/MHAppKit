//
//  UserDefaultsStored.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefaultsStored<T> {
    
    public let initialValue: T
    public let key: String
    public let userDefaults: UserDefaults
    
    public var wrappedValue: T {
        
        get {
            
            return self.userDefaults.value(forKey: self.key) as! T
        }
        
        set {
            
            if self.isNil(newValue){
                
                self.userDefaults.removeObject(forKey: self.key)
            }
            else {
                
                self.userDefaults.set(newValue, forKey: self.key)
            }
            
            self.userDefaults.synchronize()
        }
    }
    
    public var projectedValue: Self {
        
        return self
    }
    
    private var exists: Bool {
        
        return self.userDefaults.value(forKey: self.key) != nil
    }
    
    private var isCorrectType: Bool {
        
        return self.userDefaults.value(forKey: self.key) is T
    }
    
    public init(wrappedValue initialValue: T, key: String, userDefaults: UserDefaults) {
        
        self.initialValue = initialValue
        self.key = key
        self.userDefaults = userDefaults
        
        if !self.exists || !self.isCorrectType {
            
            self.wrappedValue = initialValue
        }
    }
    
    public init(wrappedValue initialValue: T, key: String) {
        
        self.init(wrappedValue: initialValue, key: key, userDefaults: .standard)
    }
    
    public func observeChanges(handler: @escaping (T) -> Void) -> Any {
        
        return self.userDefaults.observeChanges(forKey: self.key) { (value: T?) in
            
            handler(self.wrappedValue)
        }
    }
    
    private func isOptional<U>(_ value: U) -> Bool {

        return value is OptionalTypeVerifiable
    }
    
    private func isNil<U>(_ value: U) -> Bool {
        
        return (value as? OptionalTypeVerifiable)?.isNil == true
    }
}

