//
//  UIViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //MARK: - UINavigationItem Additions
    
    @IBInspectable open var removeBackTitle: Bool {
        
        get {
            
            if let item = self.navigationItem.backBarButtonItem , item.title == " " && item.target === self && item.action == nil {
                
                return true
            }
            
            return false
        }
        
        set {
            
            if newValue {
                
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: self, action: nil)
            }
        }
    }
    
    //MARK: - Dismiss @IBAction
    
    @IBAction open func dismissModalViewControllerAnimatedAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
