//
//  UIView+Lookup.swift
//  MHAppKit
//
//  Created by Milen Halachev on 27.09.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /**
     
     Lookup the receiver's view hierarchy in order to find first superviews matching the provided criteria via closure.
     
     - matching The closure used to determine if a view is matching.
     - returns: The first superview found that matches, otherwise nil.
     
     */
    
    public func superview(matching isMatching: (UIView) -> Bool) -> UIView? {
        
        if let view = self.superview {
            
            if isMatching(view) {
                
                return view
            }
            
            if let superview = view.superview(matching: isMatching) {
                
                return superview
            }
        }
        
        return nil
    }
    
    /**
     
     Lookup the receiver's view hierarchy in order to find first superviews matching a given type.
     
     - parameter type: The superview type for which to lookup. Default to T.self
     - returns: The first superview found of the given type, otherwise nil.
     
     */
    
    public func superviewOfType<T>(_ type: T.Type = T.self) -> T? {
        
        return self.superview(matching: { $0 is T }) as? T
    }
    
    /**
     
     Lookup the receiver's view hierarchy in order to find all superviews matching the provided criteria via closure.
     
     - matching The closure used to determine if a view is matching.
     - returns: All superview found of the given type.
     
     */
    
    public func superviews(matching isMatching: (UIView) -> Bool) -> [UIView] {
        
        var result: [UIView] = []
        
        if let view = self.superview {
            
            if isMatching(view) {
                
                result.append(view)
            }
            
            result += view.superviews(matching: isMatching)
        }
        
        return result
    }
    
    /**
     
     Lookup the receiver's view hierarchy in order to find all superviews matching a given type.
     
     - parameter type: The superview type for which to lookup. Default to T.self
     - returns: All superview found of the given type.
     
     */
    
    public func superviewsOfType<T>(_ type: T.Type = T.self) -> [T] {
        
        return self.superviews(matching: { $0 is T }) as! [T]
    }
}

extension UIView {
    
    /**
     
     Lookup the receiver's view hierarchy in order to find first subview matching the provided criteria via closure.
     
     - matching The closure used to determine if a view is matching.
     - returns: The first subview found that matches, otherwise nil.
     
     */
    
    public func subview(matching isMatching: (UIView) -> Bool) -> UIView? {
        
        for view in self.subviews {
            
            if isMatching(view) {
                
                return view
            }
            
            if let subview = view.subview(matching: isMatching) {
                
                return subview
            }
        }
        
        return nil
    }
    
    /**
     
     Lookup the receiver's view hierarchy in order to find a subview for the given type.
     
     - parameter type: The subview type for which to lookup.
     - returns: The first subview found of the given type, otherwise nil.
     
     */
    
    public func subviewOfType<T>(_ type: T.Type = T.self) -> T? {
        
        return self.subview(matching: { $0 is T }) as? T
    }
    
    /**
     
     Lookup the receiver's view hierarchy in order to find all subviews matching the provided criteria via closure.
     
     - matching The closure used to determine if a view is matching.
     - returns: All subview found that matches.
     
     */
    
    public func subviews(matching isMatching: (UIView) -> Bool) -> [UIView] {
        
        var result: [UIView] = []
        
        for view in self.subviews {
            
            if isMatching(view) {
                
                result.append(view)
            }
            
            result += view.subviews(matching: isMatching)
        }
        
        return result
    }
    
    /**
     
     Lookup the receiver's view hierarchy in order to find all subviews for the given type.
     
     - parameter type: The subview type for which to lookup.
     - returns: All subviews found of the given type.
     
     */
    
    public func subviewsOfType<T>(_ type: T.Type = T.self) -> [T] {
        
        return self.subviews(matching: { $0 is T }) as! [T]
    }
}


