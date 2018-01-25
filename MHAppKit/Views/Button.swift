//
//  Button.swift
//  MHAppKit
//
//  Created by Milen Halachev on 21.11.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class Button: UIButton {
    
    ///Hides the button when dynamic actions cannot be performed by the responder chain
    @IBInspectable var hideIfCannotPerformActions: Bool = false
    
    ///Disables the button when dynamic actions cannot be performed by the responder chain
    @IBInspectable var disableIfCannotPerformActions: Bool = false
    
    ///Determines whenver the receiver's responder chain can perform dynamic actions, such as actions without a specific target.
    public var canPerformDynamicActions: Bool {
        
        if let actions = self.actions(forTarget: nil, forControlEvent: self.allControlEvents) {
            
            let responderChain = self.responderChain
            
            for action in actions {
                
                //if there is single action that the chain can respond to - enable the receiver
                if responderChain.canPerformAction(Selector(action), withSender: self) {
                    
                    return true
                }
            }
        }
        
        return false
    }
    
    public func updateDynamicActionStateIfNeeded() {
        
        if self.hideIfCannotPerformActions {
            
            self.isHidden = !self.canPerformDynamicActions
        }
        
        if self.disableIfCannotPerformActions {
            
            self.isEnabled = self.canPerformDynamicActions
        }
        
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.updateDynamicActionStateIfNeeded()
    }
    
    public override var intrinsicContentSize: CGSize {
        
        var intrinsicContentSize = super.intrinsicContentSize
        
        intrinsicContentSize.height += self.titleEdgeInsets.top
        intrinsicContentSize.height += self.titleEdgeInsets.bottom
        intrinsicContentSize.width += self.titleEdgeInsets.left
        intrinsicContentSize.width += self.titleEdgeInsets.right
        
        intrinsicContentSize.height += self.imageEdgeInsets.top
        intrinsicContentSize.height += self.imageEdgeInsets.bottom
        intrinsicContentSize.width += self.imageEdgeInsets.left
        intrinsicContentSize.width += self.imageEdgeInsets.right
        
        intrinsicContentSize.height += self.contentEdgeInsets.top
        intrinsicContentSize.height += self.contentEdgeInsets.bottom
        intrinsicContentSize.width += self.contentEdgeInsets.left
        intrinsicContentSize.width += self.contentEdgeInsets.right
        
        return intrinsicContentSize
    }
}
