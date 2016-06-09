//
//  UIImage.swift
//  MHAppKit
//
//  Created by Milen Halachev on 6/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension UIImage {
    
    public convenience init?(color: UIColor) {
        
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
                
        guard let cgImage = image.CGImage else {
            
           return nil
        }
        
        self.init(CGImage: cgImage)
    }
}