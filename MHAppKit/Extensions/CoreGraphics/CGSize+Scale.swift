//
//  CGSize+Scale.swift
//  MHAppKit
//
//  Created by Milen Halachev on 15.02.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation

//based on https://gist.github.com/tomasbasham/10533743
extension CGSize {
    
    public enum ScaleMode {
        
        case fill
        case fit
    }
    
    public func scaling(to mode: ScaleMode, into size: CGSize) -> CGSize {
        
        let aspectWidth = size.width / self.width
        let aspectHeight = size.height / self.height
        let aspectRatio: CGFloat
        
        switch mode {
            
            case .fill:
                aspectRatio = max(aspectWidth, aspectHeight)
            
            case .fit:
                aspectRatio = min(aspectWidth, aspectHeight)
        }
        
        var result = CGSize.zero
        result.width = self.width * aspectRatio;
        result.height = self.height * aspectRatio;
        
        return result
    }
    
    public mutating func scale(to mode: ScaleMode, into size: CGSize) {
        
        self = self.scaling(to: mode, into: size)
    }
}
