//
//  Label.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright (c) 2016 Milen Halachev. All rights reserved.
//

import UIKit

///A UILabel subclass with some useful additions
@IBDesignable open class Label: UILabel {
    
    ///The content insets - affects intrinsicContentSize. Default to .zero
    @IBInspectable open var insets: UIEdgeInsets = .zero
    
    ///The content top insets - affects intrinsicContentSize. Default to .zero
    @IBInspectable open var topInset: CGFloat {
        
        get { return self.insets.top }
        set { self.insets.top = newValue }
    }
    
    ///The content bottom insets - affects intrinsicContentSize. Default to .zero
    @IBInspectable open var bottomInset: CGFloat {
        
        get { return self.insets.bottom }
        set { self.insets.bottom = newValue }
    }
    
    ///The content left insets - affects intrinsicContentSize. Default to .zero
    @IBInspectable open var leftInset: CGFloat {
        
        get { return self.insets.left }
        set { self.insets.left = newValue }
    }
    
    ///The content right insets - affects intrinsicContentSize. Default to .zero
    @IBInspectable open var rightInset: CGFloat {
        
        get { return self.insets.right }
        set { self.insets.right = newValue }
    }
    
    open override var intrinsicContentSize : CGSize {
        
        var intrinsicContentSize = super.intrinsicContentSize
        
        if self.text != nil && self.text?.isEmpty == false {
            
            intrinsicContentSize.height += self.insets.top
            intrinsicContentSize.height += self.insets.bottom
            intrinsicContentSize.width += self.insets.left
            intrinsicContentSize.width += self.insets.right
        }
        
        return intrinsicContentSize
    }
    
    open override func drawText(in rect: CGRect) {
        
        super.drawText(in: rect.inset(by: self.insets))
    }
}
