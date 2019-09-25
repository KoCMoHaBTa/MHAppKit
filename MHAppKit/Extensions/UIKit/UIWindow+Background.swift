//
//  UIWindow+Background.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    private static let backgroundViewTag = "UIWindowr.backgroundViewTag".hashValue
    private static let backgroundImageViewTag = "UIWindow.backgroundImageViewTag".hashValue
    
    open var backgroundView: UIView {
        
        if let backgroundView = self.viewWithTag(Self.backgroundViewTag) {
            
            return backgroundView
        }
        
        let backgroundView = UIView()
        backgroundView.tag = Self.backgroundViewTag
        backgroundView.clipsToBounds = true
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.frame = self.bounds
        
        self.insertSubview(backgroundView, at: 0)
        
        return backgroundView
    }
    
    open var backgroundImageView: UIImageView {
        
        if let backgroundImageView = self.backgroundView.viewWithTag(Self.backgroundImageViewTag) as? UIImageView {
            
            return backgroundImageView
        }
        
        let backgroundImageView = UIImageView()
        backgroundImageView.tag = Self.backgroundImageViewTag
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.frame = self.backgroundView.bounds
        
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlayView.frame = self.backgroundView.bounds
        
        self.backgroundView.addSubview(backgroundImageView)
        self.backgroundView.addSubview(overlayView)
        
        return backgroundImageView
    }
}
