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
    
    open func showAlert(from controller: UIViewController?) {
        
        self.showAlert(from: controller, retry: nil)
    }
    
    open func showAlert(from controller: UIViewController?, retry: (() -> Void)?) {
        
        let title = NSLocalizedString(self.domain, comment: "Error Domain")
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
