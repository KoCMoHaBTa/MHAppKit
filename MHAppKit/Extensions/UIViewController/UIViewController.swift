//
//  UIViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    //MARK: - UINavigationItem Additions
    
    @IBInspectable var removeBackTitle: Bool {
        
        get {
            
            if let item = self.navigationItem.backBarButtonItem where item.title == " " && item.target === self && item.action == Selector() {
                
                return true
            }
            
            return false
        }
        
        set {
            
            if newValue {
                
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.Plain, target: self, action: Selector())
            }
        }
    }
    
    //MARK: - Dismiss @IBAction
    
    @IBAction func dismissModalViewControllerAnimatedAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
