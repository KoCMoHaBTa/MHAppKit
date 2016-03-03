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
    
    func showAlert(title: String?, message: String?, action: String = NSLocalizedString("Close", comment: ""), handler: ((action: UIAlertAction?) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: handler))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showAlertController(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, actions: [UIAlertAction]) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            
            alertController.addAction(action)
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showAlertViewController(title: String?, message: String?, actions: [UIAlertAction]) {
        
        self.showAlertController(title, message: message, preferredStyle: UIAlertControllerStyle.Alert, actions: actions)
    }
    
    func showActionSheetController(title: String?, message: String?, actions: [UIAlertAction]) {
        
        self.showAlertController(title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet, actions: actions)
    }
    
    func showActionAlertViewController(title: String?, message: String?, negativeAction: String, positiveAction: String, handler: ((positive: Bool) -> Void)?) {
        
        let negativeAction = UIAlertAction(title: negativeAction, style: UIAlertActionStyle.Default) { (action) -> Void in
            
            handler?(positive: false)
        }
        
        let positiveAction = UIAlertAction(title: positiveAction, style: UIAlertActionStyle.Default) { (action) -> Void in
            
            handler?(positive: true)
        }
        
        self.showAlertViewController(title, message: message, actions: [negativeAction, positiveAction])
    }
}