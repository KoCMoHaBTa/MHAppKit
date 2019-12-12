//
//  UISegmentedControl.swift
//  MHAppKit
//
//  Created by Milen Halachev on 14.03.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

extension UISegmentedControl {
    
    open func framesForAllSegments() -> [CGRect] {
        
        let height = self.frame.size.height
        let y: CGFloat = 0
        
        var x: CGFloat = 0
        var result: [CGRect] = []
        
        for index in 0..<self.numberOfSegments {
            
            var width = self.widthForSegment(at: index)
            
            //if segments are autosized
            if width == 0 {
                
                if self.apportionsSegmentWidthsByContent {
                    
                    //segments have different size based on contet
                    //look trough their subviews
                    let title = self.titleForSegment(at: index)
                    width = self.subview(matching: { ($0 as? UILabel)?.text == title })?.superview(matching: { $0.frame.size.height == height })?.frame.size.width ?? 0
                }
                else {
                    
                    //segments have the same size based on contet
                    width = self.frame.size.width / CGFloat(self.numberOfSegments)
                }
            }
            
            let frame = CGRect(x: x, y: y, width: width, height: height)
            result.append(frame)
            x += width
        }
        
        return result
    }
    
    open func frameForSegment(at index: Int) -> CGRect {
        
        return self.framesForAllSegments()[index]
    }
}
#endif
