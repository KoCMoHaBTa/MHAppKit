//
//  Array+SplitByCount.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

extension Array {
    
    ///Splists the contents of the receiver into chunks of a given number.
    public func splitBy(_ count: UInt) -> [[Element]] {
        
        guard count > 0 else {
            
            return [self]
        }
        
        return self.reduce(into: [[]]) { (result, miniStreak) in
            
            if result[result.endIndex - 1].count == count {
                
                result.append([])
            }
            
            result[result.endIndex - 1].append(miniStreak)
        }
    }
}
