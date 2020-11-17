//
//  Array+CompactMap.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

extension Array where Element: OptionalType {
    
    public func compactMap() -> [Element.Wrapped] {
        
        return self.compactMap({ $0.wrapped })
    }
}
