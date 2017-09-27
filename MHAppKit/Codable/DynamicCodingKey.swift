//
//  DynamicCodingKey.swift
//  MHAppKit
//
//  Created by Milen Halachev on 27.09.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

///A type that can represent any single coding key dynamically
public struct DynamicCodingKey: CodingKey {
    
    public let stringValue: String
    public let intValue: Int?
    
    public init?(stringValue: String) {
        
        self.stringValue = stringValue
        self.intValue = Int(stringValue)
    }
    
    public init?(intValue: Int) {
        
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
