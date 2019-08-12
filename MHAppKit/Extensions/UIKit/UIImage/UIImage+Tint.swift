//
//  UIImage+Tint.swift
//  MHAppKit
//
//  Created by Milen Halachev on 12.08.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    ///https://stackoverflow.com/a/4684876
    public func tintedImage(with color: UIColor) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let rect = CGRect(origin: .zero, size: self.size)
        self.draw(in: rect)
        
        color.set()
        
        UIRectFillUsingBlendMode(rect, .sourceAtop)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintedImage
    }
}

