//
//  UIApplication+BackgroundTask.swift
//  MHAppKit
//
//  Created by Milen Halachev on 28.06.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    ///A covenience method for performing a background task, by handling the calls to `beginBackgroundTask` and `endBackgroundTask`. You must call the competion block when done.
    public func performBackgroundTask(withName taskName: String? = nil, handler: @escaping (_ completion: @escaping () -> Void) -> Void) {
        
        let id = self.beginBackgroundTask(withName: taskName, expirationHandler: nil)
        handler {
            
            self.endBackgroundTask(id)
        }
    }
}
