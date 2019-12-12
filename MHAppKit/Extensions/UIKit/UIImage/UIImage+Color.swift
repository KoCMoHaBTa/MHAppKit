//
//  UIImage+Color.swift
//  MHAppKit
//
//  Created by Milen Halachev on 6/9/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

#if canImport(UIKit)
import Foundation
import UIKit

extension UIImage {
    
    ///Creates an instance of the receiver with a given color and size. Default size is 1x1
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
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
#endif
