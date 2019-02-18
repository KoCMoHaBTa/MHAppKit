//
//  UserDefaults+Date.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/17/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    public func date(forKey key: String, using formatter: DateFormatter) -> Date? {
        
        guard let string = self.string(forKey: key) else {
            
            return nil
        }
        
        let value = formatter.date(from: string)
        return value
    }
    
    public func set(_ value: Date?, forKey key: String, using formatter: DateFormatter) {
        
        var string: String? = nil
        
        if let date = value {
            
            string = formatter.string(from: date)
        }
        
        self.set(string, forKey: key)
    }
}
