//
//  Dictionary+KeysSubscript.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

extension Dictionary {
    
    public subscript<T>(_ keys: T) -> [Value?] where T: Collection, T.Element == Key {
        
        return keys.map({ self[$0] })
    }
    
    public subscript<T>(_ keys: T?) -> [Value?] where T: Collection, T.Element == Key {
        
        guard let keys = keys else {
            
            return []
        }
        
        return self[keys]
    }
}
