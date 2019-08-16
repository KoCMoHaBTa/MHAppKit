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
    
    @available(*, deprecated, message: "Use AddChildViewControllerLayouter")
    public typealias AddViewLayouter = (_ container: UIView, _ child: UIView, _ completion: () -> Void) -> Void
    
    @available(*, deprecated, message: "Use AddChildViewControllerLayouter.fillBounds(with:)")
    @nonobjc public static let defaultAddViewLayouter: AddViewLayouter = { (container, child, completion) -> Void in
        
        container.addSubview(child)
        child.frame = container.bounds
        completion()
    }
    
    @available(*, deprecated, message: "Use RemoveChildViewControllerLayouter")
    public typealias RemoveViewLayouter = (_ container: UIView?, _ child: UIView, _ completion: () -> Void) -> Void
    
    @available(*, deprecated, message: "Use RemoveChildViewControllerLayouter.removeFromSuperview()")
    @nonobjc public static let defaultRemoveViewLayouter: RemoveViewLayouter = { (container, child, completion) -> Void in
        
        child.removeFromSuperview()
        completion()
    }
    
    /**
     Adds a child view controller to the receiver and puts it inside the view provided with a given layouter handler
     
     - parameter controller: The child view controller to be added. 
     - parameter view: The receiver's view into which to add the child controller's view.
     - parameter layouter: The layouter to use for positioning the child controller's view into the provided receveir view. Default to fill the bounds.
     
     - note: The layouter can be used to perform some custom animations.
     */
    
    @available(*, deprecated, message: "Use addChild(_:in:using:)")
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
    
    @available(*, deprecated, message: "Use removeChild(_:using:)")
    open func removeChildViewController(_ controller: UIViewController, layouter: RemoveViewLayouter = UIViewController.defaultRemoveViewLayouter) {
        
        controller.willMove(toParent: nil)
        
        layouter(controller.view.superview, controller.view) { () -> Void in
            
            controller.removeFromParent()
        }
    }
    
    
    @available(*, deprecated, message: "Use init(child:)")
    public convenience init(childViewController: UIViewController) {
        
        self.init()
        
        self.addChildViewController(childViewController, inView: self.view)
    }
}

extension UIViewController {
    
    ///Creates an instance of the receiver by adding a single child view controller into receive'r view.
    public convenience init(child: UIViewController) {
        
        self.init()
        
        self.addChild(child, in: self.view)
    }
    
    /**
     Adds a child view controller to the receiver and puts it inside the view provided with a given layouter handler
     
     - parameter childController: The child view controller to be added.
     - parameter view: The receiver's view into which to add the child controller's view.
     - parameter layouter: The layouter to use for positioning the child controller's view into the provided receveir view. Default to fill the bounds using auto layout.
     
     - note: The layouter can be used to perform some custom animations.
     */
    
    public func addChild(_ childController: UIViewController, in view: UIView, using layouter: AddChildViewControllerLayouter = .fillBoundsUisngAutoLayout()) {
        
        self.addChild(childController)
        
        layouter.handler(view, childController.view, {
            
            childController.didMove(toParent: self)
        })
    }
    
    /**
     Removes an existing child view controlelr from the receiver.
     
     - parameter controller: The child view controller to be removed.
     - parameter layouter: The layouter to use for positioning the child controller's view into its parent view. Default to just removing from the superview.
     
     - note: The layouter can be used to perform some custom animations.
     */
    
    public func removeChild(_ childController: UIViewController, using layouter: RemoveChildViewControllerLayouter = .removeFromSuperview()) {
        
        childController.willMove(toParent: nil)
        
        layouter.handler(childController.view.superview, childController.view) { () -> Void in
            
            childController.removeFromParent()
        }
    }
}

extension UIViewController {
    
    public struct AddChildViewControllerLayouter {
        
        let handler: (_ container: UIView, _ child: UIView, _ completion: () -> Void) -> Void
        
        public init(handler: @escaping (_ container: UIView, _ child: UIView, _ completion: () -> Void) -> Void) {
            
            self.handler = handler
        }
    }
    
    public struct RemoveChildViewControllerLayouter {
        
        let handler: (_ container: UIView?, _ child: UIView, _ completion: () -> Void) -> Void
        
        public init(handler: @escaping (_ container: UIView?, _ child: UIView, _ completion: () -> Void) -> Void) {
            
            self.handler = handler
        }
    }
}


extension UIViewController.AddChildViewControllerLayouter {
    
    public static func fillBounds(with autoresizingMask: UIView.AutoresizingMask) -> UIViewController.AddChildViewControllerLayouter {
        
        return .init { (container, child, completion: () -> Void) in
         
            container.addSubview(child)
            child.frame = container.bounds
            child.autoresizingMask = autoresizingMask
            completion()
        }
    }
    
    public static func fillBoundsUisngAutoLayout() -> UIViewController.AddChildViewControllerLayouter {
        
        return .init { (container, child, completion: () -> Void) in
            
            container.addSubview(child)
            
            child.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: child, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: child, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: child, attribute: .left, relatedBy: .equal, toItem: container, attribute: .left, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: child, attribute: .right, relatedBy: .equal, toItem: container, attribute: .right, multiplier: 1, constant: 0).isActive = true
            
            completion()
        }
    }
}

extension UIViewController.RemoveChildViewControllerLayouter {
    
    public static func removeFromSuperview() -> UIViewController.RemoveChildViewControllerLayouter {
        
        return .init { (container, child, completion: () -> Void) in
            
            child.removeFromSuperview()
            completion()
        }
    }
}

