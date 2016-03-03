//
//  UIViewTransitionAnimator.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/13/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

public class UIViewTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   
    public private(set) var duration: NSTimeInterval = 0.25
    public private(set) var options: UIViewAnimationOptions = UIViewAnimationOptions.TransitionNone
    public private(set) var completionBlock: ((finished: Bool) -> Void)?
    
    public override init() {
        
    }
    
    public init(duration: NSTimeInterval, options: UIViewAnimationOptions, completionBlock: ((finished: Bool) -> Void)?) {
        
        self.duration = duration
        self.options = options
        self.completionBlock = completionBlock
    }
    
    //MARK: - UIViewControllerAnimatedTransitioning
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return self.duration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let duration = self.transitionDuration(transitionContext)
        
        UIView.transitionFromView(fromViewController.view, toView: toViewController.view, duration: duration, options: self.options) { (finished) -> Void in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
    public func animationEnded(transitionCompleted: Bool) {
        
        self.completionBlock?(finished: transitionCompleted)
    }
}
