//
//  BadgeLabel.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright (c) 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

public class BadgeLabel: UILabel {

    public var hideAtBadgeValueZero = true
    public var animateBadgeValueChange = true
    public var padding: CGFloat = 6
    
    public var badgeValue: String? {
        
        didSet {
            
            self.text = self.badgeValue
            
            self.hidden = self.badgeValue == nil || (self.hideAtBadgeValueZero && self.badgeValue == "0")
            
            if self.animateBadgeValueChange {
                
                self.performBadgeValueChangeAnimation()
            }
        }
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.loadDefaultBadgeConfiguration()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.loadDefaultBadgeConfiguration()
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
    public override func intrinsicContentSize() -> CGSize {
        
        let size = super.intrinsicContentSize()
        
        let height = size.height + self.padding
        let width = max(size.width, size.height) + self.padding
        
        return CGSize(width: width, height: height)
    }
    
    public func loadDefaultBadgeConfiguration() {
        
        self.backgroundColor = UIColor.redColor()
        self.textColor = UIColor.whiteColor()
        self.font = UIFont.systemFontOfSize(12)
        self.textAlignment = NSTextAlignment.Center
        
        self.layer.masksToBounds = true
    }
    
    public func performBadgeValueChangeAnimation() {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.5
        animation.toValue = 1
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 1.3, 1, 1)
        
        self.layer.addAnimation(animation, forKey: "bounce")
    }
}

