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
open class Button: UIButton {
    
    ///Hides the button when dynamic actions cannot be performed by the responder chain
    @IBInspectable open var hideIfCannotPerformActions: Bool = false
    
    ///Disables the button when dynamic actions cannot be performed by the responder chain
    @IBInspectable open var disableIfCannotPerformActions: Bool = false
    
    ///Determines whenver the receiver's responder chain can perform dynamic actions, such as actions without a specific target.
    open var canPerformDynamicActions: Bool {
        
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
    
    open func updateDynamicActionStateIfNeeded() {
        
        if self.hideIfCannotPerformActions {
            
            self.isHidden = !self.canPerformDynamicActions
        }
        
        if self.disableIfCannotPerformActions {
            
            self.isEnabled = self.canPerformDynamicActions
        }
        
    }
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.updateDynamicActionStateIfNeeded()
    }
    
    open override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
        
        self.hideIfCannotPerformActions = false
        self.disableIfCannotPerformActions = false
    }
    
    open override var intrinsicContentSize: CGSize {
        
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
    
    @IBInspectable open var titleLeftAlignment: Bool = false { didSet { self.setNeedsLayout(); self.layoutIfNeeded() } }
    @IBInspectable open var titleRightAlignment: Bool = false { didSet { self.setNeedsLayout(); self.layoutIfNeeded() } }
    @IBInspectable open var titleTopAlignment: Bool = false { didSet { self.setNeedsLayout(); self.layoutIfNeeded() } }
    @IBInspectable open var titleBottomAlignment: Bool = false { didSet { self.setNeedsLayout(); self.layoutIfNeeded() } }
    
    @IBInspectable open var imageLeftAlignment: Bool = false { didSet { self.setNeedsLayout(); self.layoutIfNeeded() } }
    @IBInspectable open var imageRightAlignment: Bool = false { didSet { self.setNeedsLayout(); self.layoutIfNeeded() } }
    @IBInspectable open var imageTopAlignment: Bool = false { didSet { self.setNeedsLayout(); self.layoutIfNeeded() } }
    @IBInspectable open var imageBottomAlignment: Bool = false { didSet { self.setNeedsLayout(); self.layoutIfNeeded() } }
    
    open override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        var rect = super.titleRect(forContentRect: contentRect)
        
        if self.titleLeftAlignment {
            
            rect.origin.x = 0
            rect.origin.x += self.contentEdgeInsets.left
            rect.origin.x += self.titleEdgeInsets.left
        }
        else if self.titleRightAlignment {
            
            rect.origin.x = contentRect.maxX - rect.width
            rect.origin.x -= self.contentEdgeInsets.right
            rect.origin.x -= self.titleEdgeInsets.right
        }
        
        if self.titleTopAlignment {
            
            rect.origin.y = 0
            rect.origin.y += self.contentEdgeInsets.top
            rect.origin.y += self.titleEdgeInsets.top
        }
        else if self.titleBottomAlignment {
            
            rect.origin.y = contentRect.maxY - rect.height
            rect.origin.y -= self.contentEdgeInsets.bottom
            rect.origin.y -= self.titleEdgeInsets.bottom
        }
        
        return rect
    }
    
    open override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        var rect = super.imageRect(forContentRect: contentRect)

        if self.imageLeftAlignment {
            
            rect.origin.x = 0
            rect.origin.x += self.contentEdgeInsets.left
            rect.origin.x += self.imageEdgeInsets.left
        }
        else if self.imageRightAlignment {
            
            rect.origin.x = contentRect.maxX - rect.width
            rect.origin.x -= self.contentEdgeInsets.right
            rect.origin.x -= self.imageEdgeInsets.right
        }
        
        if self.imageTopAlignment {
            
            rect.origin.y = 0
            rect.origin.y += self.contentEdgeInsets.top
            rect.origin.y += self.imageEdgeInsets.top
        }
        else if self.imageBottomAlignment {
            
            rect.origin.y = contentRect.maxY - rect.height
            rect.origin.y -= self.contentEdgeInsets.bottom
            rect.origin.y -= self.imageEdgeInsets.bottom
        }
        
        return rect
    }
}
