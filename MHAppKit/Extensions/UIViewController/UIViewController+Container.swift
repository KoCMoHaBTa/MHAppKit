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
    
    @nonobjc private static let defaultAddViewLayouter: AddViewLayouter = { (container, child, completion) -> Void in
        
        container.addSubview(child)
        
        child.frame = container.bounds
//        child.translatesAutoresizingMaskIntoConstraints = false
//        container.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[child]|", options: [], metrics: nil, views: ["child": child]))
//        container.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[child]|", options: [], metrics: nil, views: ["child": child]))
        
        completion()
    }
    
    public typealias RemoveViewLayouter = (_ container: UIView?, _ child: UIView, _ completion: () -> Void) -> Void
    
    @nonobjc private static let defaultRemoveViewLayouter: RemoveViewLayouter = { (container, child, completion) -> Void in
        
        child.removeFromSuperview()
        //        child.translatesAutoresizingMaskIntoConstraints = true
        
        completion()
    }
    
    open func addChildViewController(_ controller: UIViewController, inView view: UIView, layouter: AddViewLayouter = UIViewController.defaultAddViewLayouter) {
        
        self.addChildViewController(controller)
        
        layouter(view, controller.view, {
            
            controller.didMove(toParentViewController: self)
        })
    }
    
    open func removeChildViewController(_ controller: UIViewController, layouter: RemoveViewLayouter = UIViewController.defaultRemoveViewLayouter) {
        
        controller.willMove(toParentViewController: nil)
        
        layouter(controller.view.superview, controller.view) { () -> Void in
            
            controller.removeFromParentViewController()
        }
    }
    
    public convenience init(childViewController: UIViewController) {
        
        self.init()
        
        self.addChildViewController(childViewController, inView: self.view)
    }
}
