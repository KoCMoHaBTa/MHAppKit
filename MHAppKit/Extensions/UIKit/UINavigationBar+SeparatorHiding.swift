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
        self.shadowImage = nil
        self.backIndicatorImage = nil
    }
    
    open func hideSeparator() {
        
        //remove the navigation bar separator
        self.shadowImage = Self.hiddenSeparatorImage
        self.backIndicatorImage = Self.hiddenSeparatorImage
    }
}

