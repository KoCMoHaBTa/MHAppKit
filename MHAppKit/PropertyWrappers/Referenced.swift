//
//  Referenced.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

///A property wrapper that wraps a type into a reference.
///Can be used to store references to value types within value types in order to be able to mutate them without mutating the value type itself.
@propertyWrapper @dynamicMemberLookup
public final class Referenced<T> {

    public var wrappedValue: T

    public var projectedValue: Referenced<T> {

        return self
    }

    public init(wrappedValue: T) {

        self.wrappedValue = wrappedValue
    }
    
    public subscript<U>(dynamicMember keyPath: WritableKeyPath<T, U>) -> U {

        get { return self.wrappedValue[keyPath: keyPath] }
        set { self.wrappedValue[keyPath: keyPath] = newValue }
    }
}

extension Referenced: Codable where T: Codable {
    
    public convenience init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        self.init(wrappedValue: try container.decode(T.self))
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue)
    }
}
