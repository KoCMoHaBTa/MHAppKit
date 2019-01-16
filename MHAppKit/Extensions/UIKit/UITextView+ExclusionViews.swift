//
//  UITextView+ExclusionViews.swift
//  MHAppKit
//
//  Created by Milen Halachev on 16.01.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    @IBOutlet public var exclusionViews: [UIView] {
        
        get { return [] }
        set {
            
            self.textContainer.exclusionPaths = newValue.map { (view) in
                
                let frame = self.convert(view.frame, from: view.superview)
                let path = UIBezierPath(rect: frame)
                return path
            }
        }
    }
}

