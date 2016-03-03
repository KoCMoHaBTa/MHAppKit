//
//  UIViewController+Container.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    typealias AddViewLayouter = (container: UIView, child: UIView, completion: () -> Void) -> Void
    
    @nonobjc private static let defaultAddViewLayouter: AddViewLayouter = { (container, child, completion) -> Void in
        
        container.addSubview(child)
        
        child.frame = container.bounds
//        child.translatesAutoresizingMaskIntoConstraints = false
//        container.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[child]|", options: [], metrics: nil, views: ["child": child]))
//        container.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[child]|", options: [], metrics: nil, views: ["child": child]))
        
        completion()
    }
    
    typealias RemoveViewLayouter = (container: UIView?, child: UIView, completion: () -> Void) -> Void
    
    @nonobjc private static let defaultRemoveViewLayouter: RemoveViewLayouter = { (container, child, completion) -> Void in
        
        child.removeFromSuperview()
        //        child.translatesAutoresizingMaskIntoConstraints = true
        
        completion()
    }
    
    func addChildViewController(controller: UIViewController, inView view: UIView, layouter: AddViewLayouter = UIViewController.defaultAddViewLayouter) {
        
        self.addChildViewController(controller)
        
        layouter(container: view, child: controller.view, completion: {
            
            controller.didMoveToParentViewController(self)
        })
    }
    
    func removeChildViewController(controller: UIViewController, layouter: RemoveViewLayouter = UIViewController.defaultRemoveViewLayouter) {
        
        controller.willMoveToParentViewController(nil)
        
        layouter(container: controller.view.superview, child: controller.view) { () -> Void in
            
            controller.removeFromParentViewController()
        }
    }
    
    convenience init(childViewController: UIViewController) {
        
        self.init()
        
        self.addChildViewController(childViewController, inView: self.view)
    }
}