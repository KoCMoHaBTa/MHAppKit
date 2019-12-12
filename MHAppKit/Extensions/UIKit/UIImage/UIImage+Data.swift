//
//  UIImage+Data.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/3/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

#if canImport(UIKit)
import Foundation
import UIKit
import ImageIO

extension UIImage {
    
    ///Represent a convertion strategy from UIImage to Data
    public enum Representation {
        
        ///Uses UIImagePNGRepresentation function
        case png
        
        ///Uses UIImageJPEGRepresentation function
        case jpeg(compressionQuality: CGFloat)
        
        ///Uses a custom handler
        case custom(handler: (UIImage) -> Data?)
        
        ///Creates a data representation of an image.
        public func data(from image: UIImage) -> Data? {
            
            switch self {
                
            case .png:
                return image.pngData()
                
            case .jpeg(let compressionQuality):
                return image.jpegData(compressionQuality: compressionQuality)
                
            case .custom(let handler):
                return handler(image)
            }
        }
    }
}

extension UIImage {
    
    /**
     Creates a data representation of the recevier.
     
     - parameter representation The represantation to use.
     - parameter metadata: The exif metadata to inject during the representation.
     - returns: A Data object or nil if the representation fails.
     */
    public func data(as representation: Representation, withMetadata metadata: [AnyHashable: Any]? = nil) -> Data? {
        
        let resultData = NSMutableData()
        
        guard
        let imageData = representation.data(from: self),
        let source = CGImageSourceCreateWithData(imageData as CFData, nil),
        let UTI = CGImageSourceGetType(source),
        let destination = CGImageDestinationCreateWithData(resultData, UTI, 1, nil)
        else {
            
            NSLog("Error: Could not create image destination")
            return nil
        }
        
        CGImageDestinationAddImageFromSource(destination, source, 0, metadata as CFDictionary?)
        
        guard
        CGImageDestinationFinalize(destination) == true
        else {
            
            NSLog("Error: Could not create data from image destination")
            return nil
        }
        
        return resultData as Data
    }
}
#endif
