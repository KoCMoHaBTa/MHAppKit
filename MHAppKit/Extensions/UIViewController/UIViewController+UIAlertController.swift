//
//  UIViewController+UIAlertController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {

    func showAlertController(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, actions: [UIAlertAction], configurator: ((alertController: UIAlertController) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            
            alertController.addAction(action)
        }
        
        configurator?(alertController: alertController)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Alert View
    
    func showAlertView(title: String?, message: String?, actions: [UIAlertAction], configurator: ((alertController: UIAlertController) -> Void)? = nil) {
        
        self.showAlertController(title, message: message, preferredStyle: .Alert, actions: actions, configurator: nil)
    }
    
    func showAlertView(title: String?, message: String?, action: UIAlertAction) {
        
        self.showAlertView(title, message: message, actions: [action])
    }
    
    func showAlertView(title: String?, message: String?, actionTitle: String? = NSLocalizedString("Close", comment: ""), handler: ((action: UIAlertAction) -> Void)?) {

        self.showAlertView(title, message: message, action: UIAlertAction(title: actionTitle, style: .Default, handler: handler))
    }
    
    func showAlertView(title: String?, message: String?, positiveActionTitle: String = NSLocalizedString("OK", comment: ""), negativeActionTitle: String = NSLocalizedString("Cancel", comment: ""), handler: (action: UIAlertAction, positive: Bool) -> Void) {
        
        self.showAlertView(title, message: message, actions: [
            
            UIAlertAction(title: positiveActionTitle, style: .Default, handler: { (action) -> Void in
                
                handler(action: action, positive: true)
                
            }),
            UIAlertAction(title: negativeActionTitle, style: .Cancel, handler: { (action) -> Void in
                
                handler(action: action, positive: false)
            })
            ])
    }

    //MARK: - Action Sheet
    
    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], configurator: ((alertController: UIAlertController) -> Void)? = nil) {
        
        self.showAlertController(title, message: message, preferredStyle: .ActionSheet, actions: actions, configurator: configurator)
    }
    
    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], popoverPresentationControllerDelegate: UIPopoverPresentationControllerDelegate) {
     
        self.showActionSheet(title, message: message, actions: actions) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.delegate = popoverPresentationControllerDelegate
        }
    }
    
    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], sourceRect: CGRect, sourceView: UIView?, configurator: ((alertController: UIAlertController) -> Void)? = nil) {
        
        self.showActionSheet(title, message: message, actions: actions) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.sourceRect = sourceRect
            alertController.popoverPresentationController?.sourceView = sourceView
            
            configurator?(alertController: alertController)
        }
    }
    
    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], sourceRect: CGRect, sourceView: UIView?, popoverPresentationControllerDelegate: UIPopoverPresentationControllerDelegate) {
        
        self.showActionSheet(title, message: message, actions: actions, sourceRect: sourceRect, sourceView: sourceView) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.delegate = popoverPresentationControllerDelegate
        }
    }

    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], barButtonItem: UIBarButtonItem) {
        
        self.showActionSheet(title, message: message, actions: actions) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.barButtonItem = barButtonItem
        }
    }
}