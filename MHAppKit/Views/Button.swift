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
