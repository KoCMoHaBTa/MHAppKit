//
//  UIViewController+Container.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public typealias AddViewLayouter = (_ container: UIView, _ child: UIView, _ completion: () -> Void) -> Void
    
    @nonobjc public static let defaultAddViewLayouter: AddViewLayouter = { (container, child, completion) -> Void in
        
        container.addSubview(child)
        
        child.frame = container.bounds
//        child.translatesAutoresizingMaskIntoConstraints = false
//        container.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[child]|", options: [], metrics: nil, views: ["child": child]))
//        container.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[child]|", options: [], metrics: nil, views: ["child": child]))
        
        completion()
    }
    
    public typealias RemoveViewLayouter = (_ container: UIView?, _ child: UIView, _ completion: () -> Void) -> Void
    
    @nonobjc public static let defaultRemoveViewLayouter: RemoveViewLayouter = { (container, child, completion) -> Void in
        
        child.removeFromSuperview()
        //        child.translatesAutoresizingMaskIntoConstraints = true
        
        completion()
    }
    
    /**
     Adds a child view controller to the receiver and puts it inside the view provided with a given layouter handler
     
     - parameter controller: The child view controller to be added. 
     - parameter view: The receiver's view into which to add the child controller's view.
     - parameter layouter: The layouter to use for positioning the child controller's view into the provided receveir view. Default to fill the bounds.
     
     - note: The layouter can be used to perform some custom animations.
     */
    
    open func addChildViewController(_ controller: UIViewController, inView view: UIView, layouter: AddViewLayouter = UIViewController.defaultAddViewLayouter) {
        
        self.addChild(controller)
        
        layouter(view, controller.view, {
            
            controller.didMove(toParent: self)
        })
    }
    
    /**
     Removes an existing child view controlelr from the receiver.
     
     - parameter controller: The child view controller to be removed.
     - parameter layouter: The layouter to use for positioning the child controller's view into its parent view. Default to just removing from the superview.
     
     - note: The layouter can be used to perform some custom animations.
     */
    
    open func removeChildViewController(_ controller: UIViewController, layouter: RemoveViewLayouter = UIViewController.defaultRemoveViewLayouter) {
        
        controller.willMove(toParent: nil)
        
        layouter(controller.view.superview, controller.view) { () -> Void in
            
            controller.removeFromParent()
        }
    }
    
    ///Creates an instance of the receiver by adding a single child view controller into receive'r view. 
    public convenience init(childViewController: UIViewController) {
        
        self.init()
        
        self.addChildViewController(childViewController, inView: self.view)
    }
}
