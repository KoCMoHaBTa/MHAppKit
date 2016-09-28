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

    open func showAlertController(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, actions: [UIAlertAction], configurator: ((_ alertController: UIAlertController) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            
            alertController.addAction(action)
        }
        
        configurator?(alertController)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Alert View
    
    open func showAlertView(title: String?, message: String?, actions: [UIAlertAction], configurator: ((_ alertController: UIAlertController) -> Void)? = nil) {
        
        self.showAlertController(title: title, message: message, preferredStyle: .alert, actions: actions, configurator: nil)
    }
    
    open func showAlertView(title: String?, message: String?, action: UIAlertAction) {
        
        self.showAlertView(title: title, message: message, actions: [action])
    }
    
    open func showAlertView(title: String?, message: String?, actionTitle: String? = NSLocalizedString("Close", comment: ""), handler: ((_ action: UIAlertAction) -> Void)?) {

        self.showAlertView(title: title, message: message, action: UIAlertAction(title: actionTitle, style: .default, handler: handler))
    }
    
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
    
    open func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], configurator: ((_ alertController: UIAlertController) -> Void)? = nil) {
        
        self.showAlertController(title: title, message: message, preferredStyle: .actionSheet, actions: actions, configurator: configurator)
    }
    
    open func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], popoverPresentationControllerDelegate: UIPopoverPresentationControllerDelegate) {
     
        self.showActionSheet(title: title, message: message, actions: actions) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.delegate = popoverPresentationControllerDelegate
        }
    }
    
    open func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], sourceRect: CGRect, sourceView: UIView?, configurator: ((_ alertController: UIAlertController) -> Void)? = nil) {
        
        self.showActionSheet(title: title, message: message, actions: actions) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.sourceRect = sourceRect
            alertController.popoverPresentationController?.sourceView = sourceView
            
            configurator?(alertController)
        }
    }
    
    open func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], sourceRect: CGRect, sourceView: UIView?, popoverPresentationControllerDelegate: UIPopoverPresentationControllerDelegate) {
        
        self.showActionSheet(title: title, message: message, actions: actions, sourceRect: sourceRect, sourceView: sourceView) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.delegate = popoverPresentationControllerDelegate
        }
    }

    open func showActionSheet(title: String?, message: String?, actions: [UIAlertAction], barButtonItem: UIBarButtonItem) {
        
        self.showActionSheet(title: title, message: message, actions: actions) { (alertController) -> Void in
            
            alertController.popoverPresentationController?.barButtonItem = barButtonItem
        }
    }
}
