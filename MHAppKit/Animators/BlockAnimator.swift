//
//  BlockAnimator.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/13/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

public class BlockAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
    public private(set) var duration: NSTimeInterval = 0.25
    public private(set) var animations: ((transitionContext: UIViewControllerContextTransitioning) -> Void)?
    public private(set) var completionBlock: ((finished: Bool) -> Void)?
    
    public override init() {
        
    }
    
    public init(duration: NSTimeInterval, animations: ((transitionContext: UIViewControllerContextTransitioning) -> Void)?, completionBlock: ((finished: Bool) -> Void)?) {
        
        self.duration = duration
        self.animations = animations
        self.completionBlock = completionBlock
    }
    
    //MARK: - UIViewControllerAnimatedTransitioning
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return self.duration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        self.animations?(transitionContext: transitionContext)
    }
    
    public func animationEnded(transitionCompleted: Bool) {
        
        self.completionBlock?(finished: transitionCompleted)
    }
}
