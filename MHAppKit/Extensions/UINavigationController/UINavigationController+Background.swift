//
//  UINavigationController+Background.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

public extension UINavigationController {
    
    private static let backgroundViewTag = "UINavigationController.backgroundViewTag".hashValue
    private static let backgroundImageViewTag = "UINavigationController.backgroundImageViewTag".hashValue
    
    var backgroundView: UIView {
        
        if let backgroundView = self.view.viewWithTag(self.dynamicType.backgroundViewTag) {
            
            return backgroundView
        }
        
        let backgroundView = UIView()
        backgroundView.tag = self.dynamicType.backgroundViewTag
        backgroundView.clipsToBounds = true
        backgroundView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        backgroundView.frame = self.view.bounds
        
        self.view.insertSubview(backgroundView, atIndex: 0)
        
        return backgroundView
    }
    
    var backgroundImageView: UIImageView {
        
        if let backgroundImageView = self.backgroundView.viewWithTag(self.dynamicType.backgroundImageViewTag) as? UIImageView {
            
            return backgroundImageView
        }
        
        let backgroundImageView = UIImageView()
        backgroundImageView.tag = self.dynamicType.backgroundImageViewTag
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImageView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        backgroundImageView.frame = self.backgroundView.bounds
        
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        overlayView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        overlayView.frame = self.backgroundView.bounds
        
        self.backgroundView.addSubview(backgroundImageView)
        self.backgroundView.addSubview(overlayView)
        
        return backgroundImageView
    }
}