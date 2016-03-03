//
//  ExtendedHitView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright (c) 2016 Milen Halachev. All rights reserved.
//

import UIKit

public class ExtendedHitView: UIView {
    
    @IBInspectable public var extendedHitLeft: CGFloat = 0.0
    @IBInspectable public var extendedHitRight: CGFloat = 0.0
    @IBInspectable public var extendedHitTop: CGFloat = 0.0
    @IBInspectable public var extendedHitBottom: CGFloat = 0.0
    
    public override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        
        let extendedHitInsets = self.extendedHitInsets()
        let relativeFrame = self.bounds
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, extendedHitInsets)
        
        return CGRectContainsPoint(hitFrame, point);
    }
    
    func extendedHitInsets() -> UIEdgeInsets {
        
        let extendedHitTop = self.extendedHitTop
        let extendedHitLeft = self.extendedHitLeft
        let extendedHitBottom = self.extendedHitBottom
        let extendedHitRight = self.extendedHitRight
        
        return UIEdgeInsets(top: extendedHitTop, left: extendedHitLeft, bottom: extendedHitBottom, right: extendedHitRight)
    }
}