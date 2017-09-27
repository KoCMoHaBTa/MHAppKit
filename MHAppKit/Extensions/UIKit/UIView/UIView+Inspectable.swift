//
//  UIView+Inspectable.swift
//  MHAppKit
//
//  Created by Milen Halachev on 27.09.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable open var cornerRadius: CGFloat {
        
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable open var maskToBounds: Bool {
        
        get { return self.layer.masksToBounds }
        set { self.layer.masksToBounds = newValue }
    }
    
    @IBInspectable open var borderWidth: CGFloat {
        
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable open var borderColor: UIColor? {
        
        get { return self.layer.borderColor == nil ? nil : UIColor(cgColor: self.layer.borderColor!) }
        set { self.layer.borderColor = newValue?.cgColor }
    }
}
