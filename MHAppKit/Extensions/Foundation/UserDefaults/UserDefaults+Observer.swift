//
//  UserDefaults+Observer.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    private class Observer: NSObject {
        
        let userDefaults: UserDefaults
        let keyPath: String
        let handler: ([NSKeyValueChangeKey : Any]?) -> Void
        
        deinit {
            
            self.userDefaults.removeObserver(self, forKeyPath: self.keyPath)
        }
        
        init(userDefaults: UserDefaults, keyPath: String, options: NSKeyValueObservingOptions = [.new], handler: @escaping ([NSKeyValueChangeKey : Any]?) -> Void) {
            
            self.userDefaults = userDefaults
            self.keyPath = keyPath
            self.handler = handler
            
            super.init()
            
            userDefaults.addObserver(self, forKeyPath: keyPath, options: options, context: nil)
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            
            self.handler(change)
        }
    }
    
    /**
     Observe changes for a given key.
     - parameter key: The for which to observe changes.
     - parameter handler: The closure called when the value for the `key` has changed.
     - returns: An observer object. You must hold strong reference to the observer object in order to recive changes. Once the observer is deallocated - no more changes are sent.
     */
    public func observeChanges<T>(forKey key: String, handler: @escaping (T?) -> Void) -> Any {
        
        return Observer(userDefaults: self, keyPath: key) { (change) in
            
            let value = change?[.newKey] as? T
            handler(value)
        }
    }
}


