//
//  UIViewController+UIAlertController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    /**
     Shows an alert controller with a given title, message, style, actions and configurator.
     
     - parameter title: See `UIAlertController` for more information.
     - parameter message: See `UIAlertController` for more information.
     - parameter preferredStyle: See `UIAlertController` for more information.
     - parameter actions: See `UIAlertController` and `UIAlertAction` for more information.
     - parameter configurator: A closure that can be used for additional configuration before presentation.
     */
    
    open func showAlertController(title: String?, message: String?, preferredStyle: UIAlertController.Style, actions: [UIAlertAction], configurator: ((_ alertController: UIAlertController) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            
            alertController.addAction(action)
        }
        
        configurator?(alertController)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Alert View
    
    /**
     Shows an alert controller with `.alert` style with a given title, message, actions and configurator.
     
     - parameter title: See `UIAlertController` for more information.
     - parameter message: See `UIAlertController` for more information.
     - parameter actions: See `UIAlertController` and `UIAlertAction` for more information.
     - parameter configurator: A closure that can be used for additional configuration before presentation.
     */
    
    open func showAlertView(title: String?, message: String?, actions: [UIAlertAction], configurator: ((_ alertController: UIAlertController) -> Void)? = nil) {
        
        self.showAlertController(title: title, message: message, preferredStyle: .alert, actions: actions, configurator: nil)
    }
    
    /**
     Shows an alert controller with `.alert` style with a given title, message and action.
     
     - parameter title: See `UIAlertController` for more information.
     - parameter message: See `UIAlertController` for more information.
     - parameter action: See `UIAlertController` and `UIAlertAction` for more information.
     */
    
    open func showAlertView(title: String?, message: String?, action: UIAlertAction) {
        
        self.showAlertView(title: title, message: message, actions: [action])
    }
    
    /**
     Shows an alert controller with `.alert` style with a given title, message and single action title and handler.
     
     - parameter title: See `UIAlertController` for more information.
     - parameter message: See `UIAlertController` for more information.
     - parameter actionTitle: The title of the action. Default to `NSLocalizedString("Close", comment: "")`
     - parameter handler: The handler of the action.
     */
    
    open func showAlertView(title: String?, message: String?, actionTitle: String? = NSLocalizedString("Close", comment: ""), handler: ((_ action: UIAlertAction) -> Void)?) {

        self.showAlertView(title: title, message: message, action: UIAlertAction(title: actionTitle, style: .default, handler: handler))
    }
    
    /**
     Shows an alert controller with `.alert` style with a given title, message, positive and negative action title and a handler.
     
     - parameter title: See `UIAlertController` for more information.
     - parameter message: See `UIAlertController` for more information.
     - parameter positiveActionTitle: The title of the positive action. Default to `NSLocalizedString("OK", comment: "")`
     - parameter negativeActionTitle: The title of the negative action. Default to `NSLocalizedString("Cancel", comment: "")`
     - parameter handler: The handler of the action.
     */
    
    open func showAlertView(title: String?, message: String?, positiveActionTitle: String = NSLocalizedString("OK", comment: ""), negativeActionTitle: String = NSLocalizedString("Cancel", comment: ""), handler: @escaping (_ action: UIAlertAction, _ positive: Bool) -> Void) {
        
        self.showAlertView(title: title, message: message, actions: [
            
            UIAlertAction(title: positiveActionTitle, style: .default, handler: { (action) -> Void in
                
                handler(action, true)
                
            }),
            UIAlertAction(title: negativeActionTitle, style: .cancel, handler: { (action) -> Void in
                
                handler(action, false)
            })
        ])
    }

    //MARK: - Action Sheet
    
    /**
     Shows an alert controller with `.actionSheet` style with a given title, message, actions and configurator.
     
     - parameter title: See `UIAlertController` for more information.
     - parameter message: See `UIAlertController` for more information.
     - parameter actions: See `UIAlertController` and `UIAlertAction` for more information.
     - parameter configurator: A closure that can be used for additional configuration before presentation.
     */
    
    open func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], configurator: ((_ alertController: UIAlertController) -> Void)? = nil) {
        
        self.showAlertController(title: title, message: message, preferredStyle: .actionSheet, actions: actions, configurator: configurator)
    }
    
    /**
     Shows an alert controller with `.actionSheet` style with a given title, message, actions and `UIPopoverPresentationControllerDelegate`.
     
     - parameter title: See `UIAlertController` for more information.
     - parameter message: See `UIAlertController` for more information.
     - parameter actions: See `UIAlertController` and `UIAlertAction` for more information.
     - parameter popoverPresentationControllerDelegate: An instance of `UIPopoverPresentationControllerDelegate` that is assigned before presentation.
     */
    
    open func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], popoverPresentationControllerDelegate: UIPopoverPresentationControllerDelegate) {
     
        self.showActionSheet(title: title, message: message, actions: actions) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.delegate = popoverPresentationControllerDelegate
        }
    }
    
    /**
     Shows an alert controller with `.actionSheet` style with a given title, message, actions, configurator and source view and rect.
     
     - parameter title: See `UIAlertController` for more information.
     - parameter message: See `UIAlertController` for more information.
     - parameter actions: See `UIAlertController` and `UIAlertAction` for more information.
     - parameter sourceRect: See `UIPopoverPresentationController` for more information.
     - parameter sourceView: See `UIPopoverPresentationController` for more information.
     - parameter configurator: A closure that can be used for additional configuration before presentation.
     */
    
    open func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], sourceRect: CGRect, sourceView: UIView?, configurator: ((_ alertController: UIAlertController) -> Void)? = nil) {
        
        self.showActionSheet(title: title, message: message, actions: actions) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.sourceRect = sourceRect
            alertController.popoverPresentationController?.sourceView = sourceView
            
            configurator?(alertController)
        }
    }
    
    /**
     Shows an alert controller with `.actionSheet` style with a given title, message, actions, `UIPopoverPresentationControllerDelegate` and source view and rect.
     
     - parameter title: See `UIAlertController` for more information.
     - parameter message: See `UIAlertController` for more information.
     - parameter actions: See `UIAlertController` and `UIAlertAction` for more information.
     - parameter sourceRect: See `UIPopoverPresentationController` for more information.
     - parameter sourceView: See `UIPopoverPresentationController` for more information.
     - parameter popoverPresentationControllerDelegate: An instance of `UIPopoverPresentationControllerDelegate` that is assigned before presentation.
     */
    
    open func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], sourceRect: CGRect, sourceView: UIView?, popoverPresentationControllerDelegate: UIPopoverPresentationControllerDelegate) {
        
        self.showActionSheet(title: title, message: message, actions: actions, sourceRect: sourceRect, sourceView: sourceView) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.delegate = popoverPresentationControllerDelegate
        }
    }
    
    /**
     Shows an alert controller with `.actionSheet` style with a given title, message, actions and source bar button item.
     
     - parameter title: See `UIAlertController` for more information.
     - parameter message: See `UIAlertController` for more information.
     - parameter actions: See `UIAlertController` and `UIAlertAction` for more information.
     - parameter barButtonItem: See `UIPopoverPresentationController` for more information.
     */

    open func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], barButtonItem: UIBarButtonItem) {
        
        self.showActionSheet(title: title, message: message, actions: actions) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.barButtonItem = barButtonItem
        }
    }
}
