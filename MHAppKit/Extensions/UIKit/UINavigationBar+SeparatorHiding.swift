//
//  UINavigationBar+SeparatorHiding.swift
//  MHAppKit
//
//  Created by Milen Halachev on 1.03.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

extension UINavigationBar {
    
    public static var hiddenSeparatorImage = UIImage()
    
    @IBInspectable open var isSeparatorHidden: Bool {
        
        get {
            
            var isSeparatorHidden = self.shadowImage === Self.hiddenSeparatorImage
            
            #if !os(tvOS)
                isSeparatorHidden = isSeparatorHidden && self.backIndicatorImage === Self.hiddenSeparatorImage
            #endif
            
            return isSeparatorHidden
        }
        set { newValue ? self.hideSeparator() : self.showSeparator() }
    }
    
    public func showSeparator() {
        
        //restore the navigation bar separator
        if #available(iOS 13.0, *), #available(tvOS 13.0, *) {
            
            self.standardAppearance.shadowColor = UINavigationBarAppearance().shadowColor
            self.compactAppearance?.shadowColor = UINavigationBarAppearance().shadowColor
            self.scrollEdgeAppearance?.shadowColor = UINavigationBarAppearance().shadowColor
        }
        else {
            
            self.shadowImage = nil
            
            #if !os(tvOS)
                self.backIndicatorImage = nil
            #endif
        }
    }
    
    public func hideSeparator() {
        
        //remove the navigation bar separator
        if #available(iOS 13.0, *), #available(tvOS 13.0, *) {
            
            self.standardAppearance.shadowColor = .clear
            self.compactAppearance?.shadowColor = .clear
            self.scrollEdgeAppearance?.shadowColor = .clear
        }
        else {
            
            self.shadowImage = Self.hiddenSeparatorImage
            
            #if !os(tvOS)
                self.backIndicatorImage = Self.hiddenSeparatorImage
            #endif
        }
    }
}
#endif
