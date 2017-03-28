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
    
    ///Sets an action handler closure that can be used instead of the standart target-action mechanism. The handler is called when the button is tapped.
    open var actionHandler: Action? {
        
        get {
            
            return (objc_getAssociatedObject(self, &UIBarButtonItem.actionHandlerKey) as? ActionWrapper)?.action
        }
        
        set {
            
            self.target = self
            self.action = #selector(handleAction(_:))
            
            objc_setAssociatedObject(self, &UIBarButtonItem.actionHandlerKey, ActionWrapper(action: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    dynamic func handleAction(_ sender: UIBarButtonItem) {
        
        self.actionHandler?(sender)
    }
}

extension UIBarButtonItem {
    
    public typealias Action = (_ sender: UIBarButtonItem) -> Void
    
    fileprivate class ActionWrapper {
        
        var action: Action
        
        init?(action: Action?) {
            
            guard let action = action else { return nil }
            
            self.action = action
        }
    }
}

extension UIBarButtonItem {
    
    ///Creates an instance of the receiver with a given image, style and action handler.
    public convenience init(image: UIImage?, style: UIBarButtonItemStyle, action: @escaping Action) {
        
        self.init(image: image, style: style, target: nil, action: nil)
        
        self.actionHandler = action
    }
    
    ///Creates an instance of the receiver with a given image, landscapeImagePhone, style and action handler.
    public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItemStyle, action: @escaping Action) {
        
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        
        self.actionHandler = action
    }
    
    ///Creates an instance of the receiver with a given title, style and action handler.
    public convenience init(title: String?, style: UIBarButtonItemStyle, action: @escaping Action) {
     
        self.init(title: title, style: style, target: nil, action: nil)
        
        self.actionHandler = action
    }
    
    ///Creates an instance of the receiver with a given systemItem and action handler.
    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, action: @escaping Action) {
        
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        
        self.actionHandler = action
    }

}
