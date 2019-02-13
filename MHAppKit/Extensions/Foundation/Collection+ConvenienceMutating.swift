//
//  Collection+ConvenienceMutating.swift
//  MHAppKit
//
//  Created by Milen Halachev on 21.11.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

extension SetAlgebra {
    
    public func inserting(_ element: Self.Element) -> Self {
        
        var collection = self
        collection.insert(element)
        return collection
    }
    
    public func removing(_ element: Self.Element) -> Self {
        
        var collection = self
        collection.remove(element)
        return collection
    }
    
    public static func +(lhs: Self, rhs: Self.Element) -> Self {
        
        return lhs.inserting(rhs)
    }
    
    public static func +(lhs: Self, rhs: Self) -> Self {
        
        return lhs.union(rhs)
    }
    
    public static func -(lhs: Self, rhs: Self.Element) -> Self {
        
        return lhs.removing(rhs)
    }
    
    public static func -(lhs: Self, rhs: Self) -> Self {
        
        return lhs.subtracting(rhs)
    }
}

extension RangeReplaceableCollection {
    
    public func inserting(_ element: Self.Element, at index: Self.Index) -> Self {
        
        var collection = self
        collection.insert(element, at: index)
        return collection
    }
    
    public func inserting(contentsOf other: Self, at index: Self.Index) -> Self {
        
        var collection = self
        collection.insert(contentsOf: other, at: index)
        return collection
    }
    
    public func appending(_ element: Self.Element) -> Self {
        
        var collection = self
        collection.append(element)
        return collection
    }
    
    public func appending(contentsOf other: Self) -> Self {
        
        var collection = self
        collection.append(contentsOf: other)
        return collection
    }
    
    public static func +(lhs: Self, rhs: Self.Element) -> Self {
        
        return lhs.appending(rhs)
    }
    
    public static func +(lhs: Self, rhs: Self) -> Self {
        
        return lhs.appending(contentsOf: rhs)
    }
}
