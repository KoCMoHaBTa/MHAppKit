//
//  Label.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright (c) 2016 Milen Halachev. All rights reserved.
//

import UIKit

@IBDesignable open class Label: UILabel {
    
    @IBInspectable open var insets: UIEdgeInsets = .zero
    
    @IBInspectable open var topInset: CGFloat {
        
        get { return self.insets.top }
        set { self.insets.top = newValue }
    }
    
    @IBInspectable open var bottomInset: CGFloat {
        
        get { return self.insets.bottom }
        set { self.insets.bottom = newValue }
    }
    
    @IBInspectable open var leftInset: CGFloat {
        
        get { return self.insets.left }
        set { self.insets.left = newValue }
    }
    
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
        
        super.drawText(in: UIEdgeInsetsInsetRect(rect, self.insets))
    }
}
