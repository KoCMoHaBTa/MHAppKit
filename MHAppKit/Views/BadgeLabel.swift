//
//  BadgeLabel.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright (c) 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

///A UILable subclass that draws itself as a badge
open class BadgeLabel: UILabel {

    ///Controls whenever to hide the badge draw when the value is 0. Default to `true`.
    open var hideAtBadgeValueZero = true
    
    ///Controls whenever to animate the badge value changes. Default to `true`.
    open var animateBadgeValueChange = true
    
    ///The padding of the content - affects intrinsicContentSize.
    open var padding: CGFloat = 6
    
    ///The badge value
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
    
    ///Loads the default badge style configuration.
    open func loadDefaultBadgeConfiguration() {
        
        self.backgroundColor = .red
        self.textColor = .white
        self.font = .systemFont(ofSize: 12)
        self.textAlignment = .center
        
        self.layer.masksToBounds = true
    }
    
    ///Performs the animation used when the badge value is changed. You can override this method in order to provide custom animation.
    open func performBadgeValueChangeAnimation() {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.5
        animation.toValue = 1
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 1.3, 1, 1)
        
        self.layer.add(animation, forKey: "bounce")
    }
}

