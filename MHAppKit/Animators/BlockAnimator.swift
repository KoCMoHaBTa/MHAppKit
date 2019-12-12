//
//  BlockAnimator.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/13/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

///A block animator represeting `UIViewControllerAnimatedTransitioning` with block handles
open class BlockAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
    ///The duration of the animation. Default to 0.25
    open private(set) var duration: TimeInterval = 0.25
    
    ///The animation handler
    open private(set) var animations: ((_ transitionContext: UIViewControllerContextTransitioning) -> Void)?
    
    ///The completion handler
    open private(set) var completionBlock: ((_ finished: Bool) -> Void)?
    
    public override init() {
        
    }
    
    ///Creates an instance of the receiver with a given duration, animations and completionBlock
    public init(duration: TimeInterval, animations: ((_ transitionContext: UIViewControllerContextTransitioning) -> Void)?, completionBlock: ((_ finished: Bool) -> Void)?) {
        
        self.duration = duration
        self.animations = animations
        self.completionBlock = completionBlock
    }
    
    //MARK: - UIViewControllerAnimatedTransitioning
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return self.duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.animations?(transitionContext)
    }
    
    open func animationEnded(_ transitionCompleted: Bool) {
        
        self.completionBlock?(transitionCompleted)
    }
}

#endif
