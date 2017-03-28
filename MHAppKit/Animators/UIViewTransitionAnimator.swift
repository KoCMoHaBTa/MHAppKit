//
//  UIViewTransitionAnimator.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/13/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

///Animator represeting `UIViewControllerAnimatedTransitioning` that performs `UIView.transtion` for a given duration and options
open class UIViewTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
    ///The duration of the animation. Default to 0.25
    open private(set) var duration: TimeInterval = 0.25
    
    ///The options of the animation
    open private(set) var options: UIViewAnimationOptions = UIViewAnimationOptions()
    
    ///The completion handler
    open private(set) var completionBlock: ((_ finished: Bool) -> Void)?
    
    public override init() {
        
    }
    
    ///Creates an instance of the receiver with a given duration, animation options and completionBlock
    public init(duration: TimeInterval, options: UIViewAnimationOptions, completionBlock: ((_ finished: Bool) -> Void)?) {
        
        self.duration = duration
        self.options = options
        self.completionBlock = completionBlock
    }
    
    //MARK: - UIViewControllerAnimatedTransitioning
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return self.duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.transition(from: fromViewController.view, to: toViewController.view, duration: duration, options: self.options) { (finished) -> Void in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    open func animationEnded(_ transitionCompleted: Bool) {
        
        self.completionBlock?(transitionCompleted)
    }
}
