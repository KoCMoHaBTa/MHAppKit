//
//  UINavigationControllerPerspectiveAnimator.swift
//  MHAppKit
//
//  Created by Milen Halachev on 11/10/15.
//  Copyright © 2015 Milen Halachev. All rights reserved.
//

import UIKit

///An animator object represeting `UIViewControllerAnimatedTransitioning` that performs perspective animation based on given `UINavigationControllerOperation` and duration
open class UINavigationControllerPerspectiveAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    ///The `UINavigationControllerOperation`. Based on this value - the perspective animation has reverse effect
    public let operation: UINavigationController.Operation
    
    ///The duration of the animation
    public let duration: TimeInterval
    
    ///Creates an instance of the receiver with a given `UINavigationControllerOperation` and duration. Duration defaults to 0.35
    public init(operation: UINavigationController.Operation, duration: TimeInterval = 0.35) {
        
        self.operation = operation
        self.duration = duration
    }
    
    //MARK: - UIViewControllerAnimatedTransitioning
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return self.duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch self.operation {
            
            case .push:
                self.animatePushTransition(using: transitionContext)
                return
            
            case .pop:
                self.animatePopTransition(using: transitionContext)
                return
            
            case .none:
                return
        }
    }
    
    //MARK: - Custom Animations
    
    open func animatePushTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
        let fromViewController = transitionContext.viewController(forKey: .from),
        let toViewController = transitionContext.viewController(forKey: .to)
        else {
            
            return
        }
        
        let containerView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        
        //put the showing view to initial state before animation - prepare for sliding
        containerView.addSubview(toViewController.view)
        toViewController.view.frame = containerView.bounds
        toViewController.view.frame.origin.x = containerView.bounds.size.width
        
        UIView.animate(withDuration: duration, delay: 0, options: [], animations: { () -> Void in
            
            //apply perspective transform on the view that is going out
            self.applyTransform(self.perspectiveTransform(), view: fromViewController.view)
            
            //apply slide animation on the view that is showing
            toViewController.view.frame.origin.x = 0
            fromViewController.view.alpha = 0
            
        }) { (finished) -> Void in
            
            let completed = finished && !transitionContext.transitionWasCancelled
            
            if completed {
                
                //apply the original transform of the view that is no longer visible - this is required because the transform is kept and if this view comes on screen by any other way - it will appear transformed, which will be unexpected
                self.applyTransform(self.originalTransform(), view: fromViewController.view)
                fromViewController.view.removeFromSuperview()
                fromViewController.view.alpha = 1
            }
            
            transitionContext.completeTransition(completed)
        }
    }
    
    open func animatePopTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
        let fromViewController = transitionContext.viewController(forKey: .from),
        let toViewController = transitionContext.viewController(forKey: .to)
        else {
            
            return
        }
        
        let containerView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        
        //put the showing view to initial state before animation - apply the perspective transform
        containerView.addSubview(toViewController.view)
        toViewController.view.frame = containerView.bounds
        
        self.applyTransform(self.perspectiveTransform(), view: toViewController.view)
        toViewController.view.alpha = 0
        
        UIView.animate(withDuration: duration, delay: 0, options: [], animations: { () -> Void in
            
            //apply the original transform of the view that is showing
            self.applyTransform(self.originalTransform(), view: toViewController.view)
            
            //apply slide animation on the view that is going out
            fromViewController.view.frame.origin.x = containerView.bounds.size.width
            
            toViewController.view.alpha = 1
            
        }) { (finished) -> Void in
            
            let completed = finished && !transitionContext.transitionWasCancelled
            
            if completed {
                
                fromViewController.view.removeFromSuperview()
            }
            
            transitionContext.completeTransition(completed)
        }
    }
    
    //MARK: - Trasnforms
    
    private func perspectiveTransform() -> CATransform3D {
        
        //i have no idea what these numbers means
        //found them here: http://whackylabs.com/rants/?p=1198
        
        let eyePosition:Float = 40.0;
        var transform:CATransform3D = CATransform3DIdentity
        transform.m34 = CGFloat(-1/eyePosition)
        
        transform = CATransform3DTranslate(transform, 0, 0, -40)
        
        return transform
    }
    
    private func originalTransform() -> CATransform3D {
        
        return CATransform3DIdentity
    }
    
    private func applyTransform(_ transform: CATransform3D, view: UIView) {
        
        view.layer.transform = transform
    }
}
