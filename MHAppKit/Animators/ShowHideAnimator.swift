//
//  ShowHideAnimator.swift
//  MHAppKit
//
//  Created by Milen Halachev on 6/22/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

open class ShowHideAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    open var duration: TimeInterval
    open var completionBlock: ((_ finished: Bool) -> Void)?
    
    public init(duration: TimeInterval = 0.25, completionBlock: ((_ finished: Bool) -> Void)? = nil) {
        
        self.duration = duration
    }
    
    //MARK: - UIViewControllerAnimatedTransitioning
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return self.duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let duration = self.transitionDuration(using: transitionContext)
        
        toViewController.view.alpha = 0
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: duration, animations: {
            
            toViewController.view.alpha = 1
            
        }) { (finished) in
            
            let completed = finished && !transitionContext.transitionWasCancelled
            
            if completed {
                
                fromViewController.view.removeFromSuperview()
            }
            
            transitionContext.completeTransition(completed)
        }
    }
    
    open func animationEnded(_ transitionCompleted: Bool) {
        
        self.completionBlock?(transitionCompleted)
    }
}
