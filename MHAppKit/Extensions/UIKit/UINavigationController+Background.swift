//
//  UINavigationController+Background.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

extension UINavigationController {
    
    private static let backgroundViewTag = "UINavigationController.backgroundViewTag".hashValue
    private static let backgroundImageViewTag = "UINavigationController.backgroundImageViewTag".hashValue
    
    public var backgroundView: UIView {

        if let backgroundView = self.view.viewWithTag(Self.backgroundViewTag) {
            
            return backgroundView
        }
        
        let backgroundView = UIView()
        backgroundView.tag = Self.backgroundViewTag
        backgroundView.clipsToBounds = true
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.frame = self.view.bounds
        
        self.view.insertSubview(backgroundView, at: 0)
        
        return backgroundView
    }
    
    public var backgroundImageView: UIImageView {
        
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
#endif
