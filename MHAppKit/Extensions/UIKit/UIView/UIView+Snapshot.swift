//
//  UIView+Snapshot.swift
//  MHAppKit
//
//  Created by Milen Halachev on 27.11.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

extension UIView {
    
    public enum SnapshotTechnique {
        
        case layerRendering
        case drawHierarchy
        
        @available(iOS 10.0, *)
        case graphicsImageRenderer
        
        case custom((UIView) -> UIImage?)
    }
    
    public func snapshot(using technique: SnapshotTechnique = .layerRendering) -> UIImage? {
        
        switch technique {
            
            case .layerRendering:
                return self.layer.snapshot()
            
            case .drawHierarchy:
                
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
                self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return image

            case .graphicsImageRenderer:
                
                if #available(iOS 10.0, *), #available(tvOS 10.0, *) {
                    
                    let rendererFormat = UIGraphicsImageRendererFormat.preferred()
                    rendererFormat.opaque = self.isOpaque
                    let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: rendererFormat)
                    
                    let snapshotImage = renderer.image { _ in
                        
                        self.drawHierarchy(in: CGRect(origin: .zero, size: self.bounds.size), afterScreenUpdates: true)
                    }
                    
                    return snapshotImage
                }
                else {
                    
                    return nil
                }
            
            case .custom(let block):
                return block(self)

        }
    }
}

extension CALayer {
    
    public func snapshot() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            self.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        
        return nil
    }
}
#endif
