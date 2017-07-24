//
//  UIImage+Color.swift
//  MHAppKit
//
//  Created by Milen Halachev on 6/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension UIImage {
    
    ///Creates an instance of the receiver with a given color. The image created with 1x1 in size
    public convenience init?(color: UIColor) {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            
            return nil
        }
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
                
        guard let cgImage = image?.cgImage else {
            
           return nil
        }
        
        self.init(cgImage: cgImage)
    }
}
