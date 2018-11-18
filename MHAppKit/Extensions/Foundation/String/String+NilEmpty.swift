//
//  String+NilEmpty.swift
//  MHAppKit
//
//  Created by Milen Halachev on 18.11.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation

extension String {
    
    ///returns nil if the receiver is empty
    public var nonEmpty: String? {
        
        return self.isEmpty ? nil : self
    }
    
    ///Trims whitespaces and newlines of the receiver and returns the trimmed receiver or nil if empty
    public var nonEmptyTrimmed: String? {
        
        return self.trimmingWhitespacesAndNewlines.nonEmpty
    }
    
    ///Trims whitespaces and newlines of the receiver and returns the result
    public var trimmingWhitespacesAndNewlines: String {
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
