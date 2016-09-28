//
//  BadgeLabel.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright (c) 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

open class BadgeLabel: UILabel {

    open var hideAtBadgeValueZero = true
    open var animateBadgeValueChange = true
    open var padding: CGFloat = 6
    
    open var badgeValue: String? {
        
        didSet {
            
            self.text = self.badgeValue
            
            self.isHidden = self.badgeValue == nil || (self.hideAtBadgeValueZero && self.badgeValue == "0")
            
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
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
    open override var intrinsicContentSize : CGSize {
        
        let size = super.intrinsicContentSize
        
        let height = size.height + self.padding
        let width = max(size.width, size.height) + self.padding
        
        return CGSize(width: width, height: height)
    }
    
    open func loadDefaultBadgeConfiguration() {
        
        self.backgroundColor = .red
        self.textColor = .white
        self.font = .systemFont(ofSize: 12)
        self.textAlignment = .center
        
        self.layer.masksToBounds = true
    }
    
    open func performBadgeValueChangeAnimation() {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.5
        animation.toValue = 1
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 1.3, 1, 1)
        
        self.layer.add(animation, forKey: "bounce")
    }
}

