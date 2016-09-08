//
//  UINavigationControllerPerspectiveAnimator.swift
//  MHAppKit
//
//  Created by Milen Halachev on 11/10/15.
//  Copyright © 2015 Milen Halachev. All rights reserved.
//

import UIKit

open class UINavigationControllerPerspectiveAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    open let operation: UINavigationControllerOperation
    open let duration: TimeInterval
    
    public init(operation: UINavigationControllerOperation, duration: TimeInterval = 0.35) {
        
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
            
            default:
                self.animateDefaultTransition(using: transitionContext)
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
    
    open func animateDefaultTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //find out when this is called and implement it according to the needs
        
        #if DEBUG
        NSException(name: "Unhandled Animation", reason: nil, userInfo: nil).raise()
        #endif
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

//extension UINavigationControllerPerspectiveAnimator {
//    
//    private static let shadowLayerName = "UINavigationControllerPerspectiveAnimator.ShadowLayer"
//    
//    func createShadowLayerForView(view: UIView) -> CALayer {
//        
//        var frame = view.frame
//        frame.size.width = 1
//        
//        let layer = CALayer()
//        layer.frame = frame
//        
//        layer.shadowColor = UIColor.blackColor().CGColor
//        layer.shadowOffset = CGSize(width: 0, height: 0)
//        layer.shadowOpacity = 1
//        layer.shadowPath = UIBezierPath(rect: layer.bounds).CGPath
//        layer.shadowRadius = 1
//        
//        return layer
//    }
//    
//    func addShadowLayerToView(layer: CALayer, view: UIView) {
//        
//        layer.name = self.dynamicType.shadowLayerName
//        view.layer.addSublayer(layer)
//    }
//    
//    func getShadowLayerFromView(view: UIView) -> CALayer? {
//        
//        return view.layer.sublayers?.filter({ $0.name == self.dynamicType.shadowLayerName }).first
//    }
//}
