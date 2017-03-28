//
//  UIViewController+SegueCoordinator.swift
//  MHAppKit
//
//  Created by Milen Halachev on 10/18/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension UIViewController {
    
    private static var segueCoordinatorKey = ""
    open var segueCoordinator: SegueCoordinator {
        
        get {
            
            return objc_getAssociatedObject(self, &UIViewController.segueCoordinatorKey) as? SegueCoordinator ?? .default
        }
        
        set {
            
            objc_setAssociatedObject(self, &UIViewController.segueCoordinatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open dynamic func prepare(usingCoordinatorFor segue: UIStoryboardSegue, sender: Any?) {
     
        self.segueCoordinator.prepare(for: segue, sender: sender)
    }
}
