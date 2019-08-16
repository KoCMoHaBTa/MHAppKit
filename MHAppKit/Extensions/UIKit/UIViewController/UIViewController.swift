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
    
    ///If set to true - removes the back button title.
    ///- note: The implementation of this method, sets a new instnace of `UIBarButtonItem`, wtih emty title to the `backBarButtonItem` of the `navigationItem` of the receiver.
    @IBInspectable open var removeBackTitle: Bool {
        
        get {
            
            if let item = self.navigationItem.backBarButtonItem , item.title == " " && item.target === self && item.action == nil {
                
                return true
            }
            
            return false
        }
        
        set {
            
            if newValue {
                
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
            }
        }
    }
    
    //MARK: - Dismiss @IBAction
    
    ///An action that calls `dimiss(animated:completion:)` on the receiver and can be assigned from Interface Builder
    @IBAction open func dismissModalViewControllerAnimatedAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

@available(iOS 11.0, *)
extension UIViewController {
    
    @IBInspectable public var additionalTopSafeAreaInsets: CGFloat {
        
        get { return self.additionalSafeAreaInsets.top }
        set { self.additionalSafeAreaInsets.top = newValue }
    }
    
    @IBInspectable public var additionalBottomSafeAreaInsets: CGFloat {
        
        get { return self.additionalSafeAreaInsets.bottom }
        set { self.additionalSafeAreaInsets.bottom = newValue }
    }
    
    @IBInspectable public var additionalLeftSafeAreaInsets: CGFloat {
        
        get { return self.additionalSafeAreaInsets.left }
        set { self.additionalSafeAreaInsets.left = newValue }
    }
    
    @IBInspectable public var additionalRightSafeAreaInsets: CGFloat {
        
        get { return self.additionalSafeAreaInsets.right }
        set { self.additionalSafeAreaInsets.right = newValue }
    }
}
