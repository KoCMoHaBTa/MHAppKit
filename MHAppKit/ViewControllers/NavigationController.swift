//
//  NavigationController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/13/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

open class NavigationController: UINavigationController {

    open var popAnimator: UIViewControllerAnimatedTransitioning?
    open var pushAnimator: UIViewControllerAnimatedTransitioning?
    
    open private(set) var popInteractionController: UIPercentDrivenInteractiveTransition?
    open private(set) var popInteractiveGestureRecognizer: UIGestureRecognizer? = { () -> UIGestureRecognizer? in
       
        let popInteractiveGestureRecognizer = UIScreenEdgePanGestureRecognizer()
        popInteractiveGestureRecognizer.edges = .left
        
        return popInteractiveGestureRecognizer
    }()
    
    /*

    http://stackoverflow.com/questions/32707698/custom-unwind-segue-for-ios-8-and-ios-9
    
    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
        
        if toViewController.providesCustomUnwindSegueToViewController(toViewController, fromViewController: fromViewController, identifier: identifier) {
            
            return toViewController.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)
        }
        
        return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)
    }

    */
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.delegate = self
        
        if let popInteractiveGestureRecognizer = self.popInteractiveGestureRecognizer {
        
            popInteractiveGestureRecognizer.addTarget(self, action: #selector(NavigationController.handleInteractivePopGestureRecognizer(_:)))
            popInteractiveGestureRecognizer.delegate = self
            self.view.addGestureRecognizer(popInteractiveGestureRecognizer)
        }
    }
    
    open func handleInteractivePopGestureRecognizer(_ recongnizer: UIGestureRecognizer) {
        
        if self.popAnimator == nil {
            
            return
        }
        
        var progress = recongnizer.location(in: recongnizer.view).x / recongnizer.view!.bounds.size.width * 1
        progress = min(1, max(0, progress))
        
        switch recongnizer.state {
            
            case .began:
                self.popInteractionController = UIPercentDrivenInteractiveTransition()
                self.popViewController(animated: true)
                
            case .changed:
                self.popInteractionController?.update(progress)
                
            case .ended, .cancelled, .failed:
                
                if progress > 0.5 {
                    
                    self.popInteractionController?.finish()
                }
                else {
                    
                    self.popInteractionController?.cancel()
                }
                
                self.popInteractionController = nil
                
            default:
                print("")
        }
        
    }
}

//MARK: - BaseNavigationController: UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if let viewController = viewController as? UINavigationControllerPreferencesProvider {
            
            if viewController.providesNavigationControllerPreferences() {
                
                let prefersNavigationBarHidden = viewController.prefersNavigationBarHidden()
                navigationController.setNavigationBarHidden(prefersNavigationBarHidden, animated: animated)
            }
        }
        
        let toolbarItemsCount = viewController.toolbarItems?.count ?? 0
        navigationController.setToolbarHidden(toolbarItemsCount < 1, animated: true)
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = { [unowned self] (operation: UINavigationControllerOperation) -> UIViewControllerAnimatedTransitioning? in
            
            switch operation {
                
                case .pop:
                    return self.popAnimator
                
                case .push:
                    return self.pushAnimator
                
                default:
                    return nil
            }
            
        }(operation)
        
            ?? fromVC.preferedNavigationAnimator(for: operation, toController: toVC)
            ?? toVC.preferedNavigationAnimator(for: operation, fromController: fromVC)
        
        return animator
    }

    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        if animationController === self.popAnimator {
            
            return self.popInteractionController
        }
        
        return nil
    }
    
    open override func responds(to aSelector: Selector) -> Bool {
        
        let respond = super.responds(to: aSelector)
        
        if aSelector == #selector(UINavigationControllerDelegate.navigationController(_:animationControllerFor:from:to:)) && respond && self.popAnimator == nil {
            
            return false
        }
        
        return respond
    }
}

//MARK: - BaseNavigationController: UIGestureRecognizerDelegate

extension NavigationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if otherGestureRecognizer !== self.interactivePopGestureRecognizer {
            
            otherGestureRecognizer.isEnabled = false
            otherGestureRecognizer.isEnabled = true
            
            return true
        }
        
        return false
    }
}

extension UIViewController {
    
    //used when presentor defines the transition to the presented controller
    open func preferedNavigationAnimator(for operation: UINavigationControllerOperation, toController controller: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return nil
    }
    
    //used when presented controller defines its own transition
    open func preferedNavigationAnimator(for operation: UINavigationControllerOperation, fromController controller: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return nil
    }
    
    /*

    http://stackoverflow.com/questions/32707698/custom-unwind-segue-for-ios-8-and-ios-9
    
    func providesCustomUnwindSegueToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> Bool {
        
        return false
    }

    */
}

public protocol UINavigationControllerPreferencesProvider {
    
    func providesNavigationControllerPreferences() -> Bool
    func prefersNavigationBarHidden() -> Bool
    //    func prefersToolBarHidden() -> Bool
}




