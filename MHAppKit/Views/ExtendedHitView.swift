//
//  ExtendedHitView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright (c) 2016 Milen Halachev. All rights reserved.
//

import UIKit

///An UIView subclass that can extends/shrink its hit area beyond/within its bounds.
open class ExtendedHitView: UIView {
    
    @IBInspectable open var extendedHitLeft: CGFloat = 0.0
    @IBInspectable open var extendedHitRight: CGFloat = 0.0
    @IBInspectable open var extendedHitTop: CGFloat = 0.0
    @IBInspectable open var extendedHitBottom: CGFloat = 0.0
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        let extendedHitInsets = self.extendedHitInsets()
        let relativeFrame = self.bounds
        let hitFrame = relativeFrame.inset(by: extendedHitInsets)
        
        return hitFrame.contains(point);
    }
    
    func extendedHitInsets() -> UIEdgeInsets {
        
        let extendedHitTop = self.extendedHitTop
        let extendedHitLeft = self.extendedHitLeft
        let extendedHitBottom = self.extendedHitBottom
        let extendedHitRight = self.extendedHitRight
        
        return UIEdgeInsets(top: extendedHitTop, left: extendedHitLeft, bottom: extendedHitBottom, right: extendedHitRight)
    }
}
