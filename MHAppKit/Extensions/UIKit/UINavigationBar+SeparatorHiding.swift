//
//  UINavigationBar+SeparatorHiding.swift
//  MHAppKit
//
//  Created by Milen Halachev on 1.03.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    public static var hiddenSeparatorImage = UIImage()
    
    @IBInspectable open var isSeparatorHidden: Bool {
        
        get { return self.shadowImage === Self.hiddenSeparatorImage && self.backIndicatorImage === Self.hiddenSeparatorImage }
        set { newValue ? self.hideSeparator() : self.showSeparator() }
    }
    
    open func showSeparator() {
        
        //restore the navigation bar separator
        if #available(iOS 13.0, *) {
            
            self.standardAppearance.shadowColor = UINavigationBarAppearance().shadowColor
            self.compactAppearance?.shadowColor = UINavigationBarAppearance().shadowColor
            self.scrollEdgeAppearance?.shadowColor = UINavigationBarAppearance().shadowColor
        }
        else {
            
            self.shadowImage = nil
            self.backIndicatorImage = nil
        }
    }
    
    open func hideSeparator() {
        
        //remove the navigation bar separator
        if #available(iOS 13.0, *) {
            
            self.standardAppearance.shadowColor = .clear
            self.compactAppearance?.shadowColor = .clear
            self.scrollEdgeAppearance?.shadowColor = .clear
        }
        else {
            
            self.shadowImage = Self.hiddenSeparatorImage
            self.backIndicatorImage = Self.hiddenSeparatorImage
        }
    }
}

