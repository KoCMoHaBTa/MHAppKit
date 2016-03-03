//
//  NSError+Presentation.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

public extension NSError {
    
    func showAlertFrom(controller: UIViewController?) {
        
        self.showAlertFrom(controller, retry: nil)
    }
    
    func showAlertFrom(controller: UIViewController?, retry: (() -> Void)?) {
        
        let title = NSLocalizedString(self.domain, comment: "Error Domain")
        let message = self.localizedDescription
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: UIAlertActionStyle.Cancel, handler: nil))
        
        if let retry = retry {
            
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                
                retry()
            }))
        }
        
        controller?.presentViewController(alertController, animated: true, completion: nil)
    }
}