//
//  UIViewController+Lookup.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    ///Lookup the visible view controller, starting form the receiver. This is useful if you want to find the currently visivle view controller from your root view controller.
    open func lookupVisibleViewController() -> UIViewController {
        
        if let presentedViewController = self.presentedViewController {
            
            return presentedViewController.lookupVisibleViewController()
        }
        
        if let navigationController = self as? UINavigationController {
            
            return navigationController.visibleViewController?.lookupVisibleViewController() ?? self
        }
        
        if let tabBarController = self as? UITabBarController {
            
            return tabBarController.selectedViewController?.lookupVisibleViewController() ?? self
        }
        
        return self
    }
}

extension UIViewController {
    
    ///Returns a sequence of the composition of all child view controllers
    open var allChildViewControllers: [UIViewController] {
        
        return self.children + self.children.flatMap({ $0.allChildViewControllers })
    }
}

extension UIViewController {
    
    /**
     
     Lookup the receiver's view controller hierarchy in order to find first parent matching the provided criteria via closure.
     
     - matching The closure used to determine if a view controller is matching.
     - returns: The first parent found that matches, otherwise nil.
     
     */
    
    public func parent(matching isMatching: (UIViewController) -> Bool) -> UIViewController? {
        
        if let parent = self.parent {
            
            if isMatching(parent) {
                
                return parent
            }
            
            if let parent = parent.parent(matching: isMatching) {
                
                return parent
            }
        }
        
        return nil
    }
    
    /**
     
     Lookup the receiver's view controller hierarchy in order to find first parent matching a given type.
     
     - parameter type: The parent type for which to lookup. Default to T.self
     - returns: The first parent found of the given type, otherwise nil.
     
     */
    
    public func parentOfType<T>(_ type: T.Type = T.self) -> T? {
        
        return self.parent(matching: { $0 is T }) as? T
    }
    
    /**
     
     Lookup the receiver's view controller hierarchy in order to find all parents matching the provided criteria via closure.
     
     - matching The closure used to determine if a view controller is matching.
     - returns: All parents found of the given type.
     
     */
    
    public func parents(matching isMatching: (UIViewController) -> Bool) -> [UIViewController] {
        
        var result: [UIViewController] = []
        
        if let parent = self.parent {
            
            if isMatching(parent) {
                
                result.append(parent)
            }
            
            result += parent.parents(matching: isMatching)
        }
        
        return result
    }
    
    /**
     
     Lookup the receiver's view controller hierarchy in order to find all parents matching a given type.
     
     - parameter type: The parent type for which to lookup. Default to T.self
     - returns: All parents found of the given type.
     
     */
    
    public func parentsOfType<T>(_ type: T.Type = T.self) -> [T] {
        
        return self.parents(matching: { $0 is T }) as! [T]
    }
}

extension UIViewController {
    
    /**
     
     Lookup the receiver's view controller hierarchy in order to find first child matching the provided criteria via closure.
     
     - matching The closure used to determine if a view controller is matching.
     - returns: The first child found that matches, otherwise nil.
     
     */
    
    public func child(matching isMatching: (UIViewController) -> Bool) -> UIViewController? {
        
        for child in self.children {
            
            if isMatching(child) {
                
                return child
            }
            
            if let child = child.child(matching: isMatching) {
                
                return child
            }
        }
        
        return nil
    }
    
    /**
     
     Lookup the receiver's view controller hierarchy in order to find a subview for the given type.
     
     - parameter type: The child type for which to lookup.
     - returns: The first child found of the given type, otherwise nil.
     
     */
    
    public func childOfType<T>(_ type: T.Type = T.self) -> T? {
        
        return self.child(matching: { $0 is T }) as? T
    }
    
    /**
     
     Lookup the receiver's view controller hierarchy in order to find all children matching the provided criteria via closure.
     
     - matching The closure used to determine if a view controller is matching.
     - returns: All children found that matches.
     
     */
    
    public func children(matching isMatching: (UIViewController) -> Bool) -> [UIViewController] {
        
        var result: [UIViewController] = []
        
        for child in self.children {
            
            if isMatching(child) {
                
                result.append(child)
            }
            
            result += child.children(matching: isMatching)
        }
        
        return result
    }
    
    /**
     
     Lookup the receiver's view hierarchy in order to find all subviews for the given type.
     
     - parameter type: The subview type for which to lookup.
     - returns: All subviews found of the given type.
     
     */
    
    public func childrenOfType<T>(_ type: T.Type = T.self) -> [T] {
        
        return self.children(matching: { $0 is T }) as! [T]
    }
}



