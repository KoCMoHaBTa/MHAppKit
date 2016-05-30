//
//  UIBarButtonItem+Action.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5/30/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    private static var actionHandlerKey = ""
    
    public var actionHandler: Action? {
        
        get {
            
            return (objc_getAssociatedObject(self, &UIBarButtonItem.actionHandlerKey) as? ActionWrapper)?.action
        }
        
        set {
            
            self.target = self
            self.action = #selector(handleAction(_:))
            
            objc_setAssociatedObject(self, &UIBarButtonItem.actionHandlerKey, ActionWrapper(action: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    dynamic func handleAction(sender: UIBarButtonItem) {
        
        self.actionHandler?(sender: sender)
    }
}

extension UIBarButtonItem {
    
    public typealias Action = (sender: UIBarButtonItem) -> Void
    
    private class ActionWrapper {
        
        var action: Action
        
        init?(action: Action?) {
            
            guard let action = action else { return nil }
            
            self.action = action
        }
    }
}

extension UIBarButtonItem {
    
    public convenience init(image: UIImage?, style: UIBarButtonItemStyle, action: Action) {
        
        self.init(image: image, style: style, target: nil, action: nil)
        
        self.actionHandler = action
    }
    
    public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItemStyle, action: Action) {
        
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        
        self.actionHandler = action
    }
    
    public convenience init(title: String?, style: UIBarButtonItemStyle, action: Action) {
     
        self.init(title: title, style: style, target: nil, action: nil)
        
        self.actionHandler = action
    }
    
    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, action: Action) {
        
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        
        self.actionHandler = action
    }

}