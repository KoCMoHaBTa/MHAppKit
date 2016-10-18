//
//  UIViewController+SegueCoordinator.swift
//  MHAppKit
//
//  Created by Milen Halachev on 10/18/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

//the magic of excuting segue prepare handlers
//!!! In order for this to work - you must call super if you override prepareForSegue method
extension UIViewController {
    
    private static let initializeIMPL: Void = {
        
        let m1 = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.prepare(for:sender:)))
        let m2 = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.sph_prepare(for:sender:)))
        method_exchangeImplementations(m1, m2)
    }()
    
    override open class func initialize() {
        
        guard self === UIViewController.self else { return }
        _ = self.initializeIMPL
    }
    
    private dynamic func sph_prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.segueCoordinator.prepare(for: segue, sender: sender)
        self.sph_prepare(for: segue, sender: sender)
    }
}

extension UIViewController {
    
    private static var segueCoordinatorKey = ""
    public var segueCoordinator: SegueCoordinator {
        
        get {
            
            return objc_getAssociatedObject(self, &UIViewController.segueCoordinatorKey) as? SegueCoordinator ?? .default
        }
        
        set {
            
            objc_setAssociatedObject(self, &UIViewController.segueCoordinatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
