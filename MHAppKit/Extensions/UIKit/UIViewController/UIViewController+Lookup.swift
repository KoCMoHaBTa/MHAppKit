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
    
    ///Returns a sequence of the composition of all child view controllers
    open var allChildViewControllers: [UIViewController] {
        
        return self.childViewControllers + self.childViewControllers.flatMap({ $0.allChildViewControllers })
    }
}
