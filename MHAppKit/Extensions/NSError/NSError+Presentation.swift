//
//  NSError+Presentation.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension NSError {
    
    ///Shows an alert, representing the receiver, from a given view controller
    open func showAlert(from controller: UIViewController?) {
        
        self.showAlert(from: controller, retry: nil)
    }
    
    /**
     Shows an alert, representing the receiver, from a given view controller with retry handler.
     
     The alert shown has the following characteristics:
     - title: `NSLocalizedString(self.domain, comment: "")`
     - message: `self.localizedDescription`
     - cancel action: NSLocalizedString("Close", comment: "")
     - retry action: NSLocalizedString("Retry", comment: "")
     */
    
    open func showAlert(from controller: UIViewController?, retry: (() -> Void)?) {
        
        let title = NSLocalizedString(self.domain, comment: "")
        let message = self.localizedDescription
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel, handler: nil))
        
        if let retry = retry {
            
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: .default, handler: { (action) -> Void in
                
                retry()
            }))
        }
        
        controller?.present(alertController, animated: true, completion: nil)
    }
}
