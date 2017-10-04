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
     
     Lookup the receiver's view hierarchy in order to find a superview for the given type.
     
     - parameter type: The superview type for which to lookup.
     - returns: The first superview found of the given type, otherwise nil.
     
     */
    
    public func superviewOfType<T>(_ type: T.Type) -> T? {
        
        return self.superview?.superviewOfType()
    }
    
    /**
     
     Lookup the receiver's view hierarchy in order to find a superview for the given type.
     
     - returns: The first superview found of the given type, otherwise nil.
     
     */
    
    public func superviewOfType<T>() -> T? {
        
        if let superview = self.superview as? T {
            
            return superview
        }
        
        return self.superview?.superviewOfType()
    }
    
    /**
     
     Lookup the receiver's view hierarchy in order to find a subview for the given type.
     
     - parameter type: The subview type for which to lookup.
     - returns: The first subview found of the given type, otherwise nil.
     
     */
    
    public func subviewOfType<T>(_ type: T.Type) -> T? {
        
        return self.subviewOfType()
    }
    
    /**
     
     Lookup the receiver's view hierarchy in order to find a subview for the given type.
     
     - returns: The first subview found of the given type, otherwise nil.
     
     */
    
    public func subviewOfType<T>() -> T? {
        
        func lookupSubviews<T>(in view: UIView) -> T? {
            
            for subview in view.subviews {
                
                if let subview = subview as? T {
                    
                    return subview
                }
                
                if let subview: T = lookupSubviews(in: subview) {
                    
                    return subview
                }
            }
            
            return nil
        }
        
        return lookupSubviews(in: self)
    }
}

extension UIView {
    
    func subview(matching isMatching: (UIView) -> Bool) -> UIView? {
        
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
}



