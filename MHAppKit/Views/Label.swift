//
//  Label.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright (c) 2016 Milen Halachev. All rights reserved.
//

import UIKit

@IBDesignable public class Label: UILabel {
    
    @IBInspectable public var insets: UIEdgeInsets = UIEdgeInsetsZero
    
    @IBInspectable public var topInset: CGFloat {
        
        get { return self.insets.top }
        set { self.insets.top = newValue }
    }
    
    @IBInspectable public var bottomInset: CGFloat {
        
        get { return self.insets.bottom }
        set { self.insets.bottom = newValue }
    }
    
    @IBInspectable public var leftInset: CGFloat {
        
        get { return self.insets.left }
        set { self.insets.left = newValue }
    }
    
    @IBInspectable public var rightInset: CGFloat {
        
        get { return self.insets.right }
        set { self.insets.right = newValue }
    }
    
    public override func intrinsicContentSize() -> CGSize {
        
        var intrinsicContentSize = super.intrinsicContentSize()
        
        if self.text != nil && self.text?.isEmpty == false {
            
            intrinsicContentSize.height += self.insets.top
            intrinsicContentSize.height += self.insets.bottom
            intrinsicContentSize.width += self.insets.left
            intrinsicContentSize.width += self.insets.right
        }
        
        return intrinsicContentSize
    }
}
