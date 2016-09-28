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
