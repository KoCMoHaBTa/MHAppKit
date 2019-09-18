//
//  UIViewController+ErrorAlert.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.09.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension UIViewController {
    
    ///A default handler, which is executed in case the app is in backgroud when `UIViewController.showError(_:title:closeTitle:retryTitle:closeHandler:backgroundHandler:retryHandler:)` is called. Default to showing a local notification with the provided title and message. In case you'd like to customize this behaviour, eg. adding actions - you can provude your own custom default handler.
    public static var showErrorDefaultBackgroundHandler: (String, String?) -> Void = { (title, message) in
        
        //show local notification
        if #available(iOS 10.0, *) {
            
            let content = UNMutableNotificationContent(title: title, body: message)
            let request = UNNotificationRequest(content: content)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        else {
            
            let notification = UILocalNotification()
            notification.fireDate = nil
            notification.alertBody = message
            
            if #available(iOS 8.2, *) {
                
                notification.alertTitle = title
            }
            
            UIApplication.shared.scheduleLocalNotification(notification)
        }
    }
    
    /**
    Shows an alert representation of a given error within the receiver's context. If the alert is presented withing a background state - a local notification is also shown.
    
    - parameter error: The error to show. If nil, no error will be shown. This parameter is optional for convenience.
    - parameter title: The alert title.
    - parameter closeTitle: The title of the close button of the alert. Default to `NSLocalizedString("Close", comment: "")`.
    - parameter retryTitle: The title of the retry button of the alert. Default to `NSLocalizedString("Retry", comment: "")`.
    - parameter backgroundHandler: An optional handler, executed if the alert is gong to be shown, when the app is in the background. Default to `UIViewController.showErrorDefaultBackgroundHandler`, which shows a local notification.
    - parameter closeHandler: An optional close handler. Default to `nil`.
    - parameter retryHandler: An optional retry handler. If `nil`, no retry option is presented.
    */
    
    public func showError(_ error: Error?, title: String, closeTitle: String = NSLocalizedString("Close", comment: ""), retryTitle: String = NSLocalizedString("Retry", comment: ""), closeHandler: (() -> Void)? = nil, backgroundHandler: ((String, String?) -> Void)? = UIViewController.showErrorDefaultBackgroundHandler, retryHandler: (() -> Void)?) {
        
        guard let error = error else {
            
            return
        }
        
        let message = error.localizedDescription
        
        if UIApplication.shared.applicationState != .active {
            
            backgroundHandler?(title, message)
        }
        
        var actions: [UIAlertAction] = [
            
            UIAlertAction(title: closeTitle, style: .cancel, handler: { (_) in
                
                closeHandler?()
            })
        ]
        
        if let retryHandler = retryHandler {
            
            actions.append(UIAlertAction(title: retryTitle, style: .default, handler: { (_) in
                
                retryHandler()
            }))
        }
        
        self.showAlertView(title: title, message: message, actions: actions)
    }
}
