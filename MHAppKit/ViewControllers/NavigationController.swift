//
//  NavigationController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/13/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

public class NavigationController: UINavigationController {

    public var popAnimator: UIViewControllerAnimatedTransitioning?
    public var pushAnimator: UIViewControllerAnimatedTransitioning?
    
    public private(set) var popInteractionController: UIPercentDrivenInteractiveTransition?
    public private(set) var popInteractiveGestureRecognizer: UIGestureRecognizer? = { () -> UIGestureRecognizer? in
       
        let popInteractiveGestureRecognizer = UIScreenEdgePanGestureRecognizer()
        popInteractiveGestureRecognizer.edges = .Left
        
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
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.delegate = self
        
        if let popInteractiveGestureRecognizer = self.popInteractiveGestureRecognizer {
        
            popInteractiveGestureRecognizer.addTarget(self, action: "handleInteractivePopGestureRecognizer:")
            popInteractiveGestureRecognizer.delegate = self
            self.view.addGestureRecognizer(popInteractiveGestureRecognizer)
        }
    }
    
    public func handleInteractivePopGestureRecognizer(recongnizer: UIGestureRecognizer) {
        
        if self.popAnimator == nil {
            
            return
        }
        
        var progress = recongnizer.locationInView(recongnizer.view).x / recongnizer.view!.bounds.size.width * 1
        progress = min(1, max(0, progress))
        
        switch recongnizer.state {
            
            case .Began:
                self.popInteractionController = UIPercentDrivenInteractiveTransition()
                self.popViewControllerAnimated(true)
                
            case .Changed:
                self.popInteractionController?.updateInteractiveTransition(progress)
                
            case .Ended, .Cancelled, .Failed:
                
                if progress > 0.5 {
                    
                    self.popInteractionController?.finishInteractiveTransition()
                }
                else {
                    
                    self.popInteractionController?.cancelInteractiveTransition()
                }
                
                self.popInteractionController = nil
                
            default:
                print("")
        }
        
    }
}

//MARK: - BaseNavigationController: UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    
    public func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        if let viewController = viewController as? UINavigationControllerPreferencesProvider {
            
            if viewController.providesNavigationControllerPreferences() {
                
                let prefersNavigationBarHidden = viewController.prefersNavigationBarHidden()
                navigationController.setNavigationBarHidden(prefersNavigationBarHidden, animated: animated)
            }
        }
        
        let toolbarItemsCount = viewController.toolbarItems?.count ?? 0
        navigationController.setToolbarHidden(toolbarItemsCount < 1, animated: true)
    }
    
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = { [unowned self] (operation: UINavigationControllerOperation) -> UIViewControllerAnimatedTransitioning? in
            
            switch operation {
                
                case .Pop:
                    return self.popAnimator
                
                case .Push:
                    return self.pushAnimator
                
                default:
                    return nil
            }
            
        }(operation)
        
        ?? fromVC.preferedNavigationAnimator(operation, toController: toVC)
        ?? toVC.preferedNavigationAnimator(operation, fromController: fromVC)
        
        return animator
    }

    public func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        if animationController === self.popAnimator {
            
            return self.popInteractionController
        }
        
        return nil
    }
    
    public override func respondsToSelector(aSelector: Selector) -> Bool {
        
        let respond = super.respondsToSelector(aSelector)
        
        if aSelector == "navigationController:animationControllerForOperation:fromViewController:toViewController:" && respond && self.popAnimator == nil {
            
            return false
        }
        
        return respond
    }
}

//MARK: - BaseNavigationController: UIGestureRecognizerDelegate

extension NavigationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if otherGestureRecognizer !== self.interactivePopGestureRecognizer {
            
            otherGestureRecognizer.enabled = false
            otherGestureRecognizer.enabled = true
            
            return true
        }
        
        return false
    }
}

public extension UIViewController {
    
    //used when presentor defines the transition to the presented controller
    func preferedNavigationAnimator(operation: UINavigationControllerOperation, toController controller: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return nil
    }
    
    //used when presented controller defines its own transition
    func preferedNavigationAnimator(operation: UINavigationControllerOperation, fromController controller: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
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




