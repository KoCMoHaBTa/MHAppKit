//
//  NSError+Presentation.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

extension NSError {
    
    ///Shows an alert, representing the receiver, from a given view controller
    @available(*, deprecated, message: "Use showAsAlert(withTitle:from:closeTitle:retryTitle:closeHandler:backgroundHandler:retryHandler:) instead.")
    public func showAlert(from controller: UIViewController?) {
        
        self.showAlert(from: controller, retry: nil)
    }
    
    /**
     Shows an alert, representing the receiver, from a given view controller with retry handler.
     
     The alert shown has the following characteristics:
     - title: `self.domain`
     - message: `self.localizedDescription`
     - cancel action: NSLocalizedString("Close", comment: "")
     - retry action: NSLocalizedString("Retry", comment: "")
     */
    
    @available(*, deprecated, message: "Use showAsAlert(withTitle:from:closeTitle:retryTitle:closeHandler:backgroundHandler:retryHandler:) instead.")
    public func showAlert(from controller: UIViewController?, retry: (() -> Void)?) {
        
        let title = self.domain
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

@available(tvOS 10.0, *)
extension Error {
    
    ///Show the receiver as a local notification.
    ///- parameter title: The title of the notification
    ///- parameter configurationHandler: A closure used for addition  configuration of the UNMutableNotificationContent
    ///- note: The message of the notification is the receiver's `localizedDescription`.
    
    @available(tvOS, unavailable)
    @available(iOS 10, *)
    public func showAsLocalNotification(withTitle title: String, configurationHandler: ((UNMutableNotificationContent) -> Void)) {
        
        let message = self.localizedDescription
        
        let content = UNMutableNotificationContent(title: title, body: message)
        configurationHandler(content)
        
        let request = UNNotificationRequest(content: content)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    ///Show the receiver as a local notification.
    ///- parameter title: The title of the notification
    ///- note: The message of the notification is the receiver's `localizedDescription`.
    @available(tvOS, unavailable)
    public func showAsLocalNotification(withTitle title: String) {
        
        self.showAsLocalNotification(withTitle: title) { (notificationContent: UNMutableNotificationContent) in

            //default empty configuration
        }
    }
    
    @available(tvOS, unavailable)
    public static var _defaultBackgroundHandler: (Error, String) -> Void {
        
        return { $0.showAsLocalNotification(withTitle: $1) }
    }
    
    ///Show the receiver as an alert view.
    ///- parameter title: The title of the notification
    ///- parameter viewController: The view controller from which to show the alert.
    ///- parameter closeTitle: The title of the close button of the alert. Default to `NSLocalizedString("Close", comment: "")`.
    ///- parameter retryTitle: The title of the retry button of the alert. Default to `NSLocalizedString("Retry", comment: "")`.
    ///- parameter backgroundHandler: An optional handler, executed if the alert is gong to be shown, when the app is in the background. Default to showing the receiver as a local notification.
    ///- parameter closeHandler: An optional close handler. Default to `nil`.
    ///- parameter retryHandler: An optional retry handler. If `nil`, no retry option is presented.
    ///- note: If the view controller is nil, the backgroundHandler is executed.
    @available(tvOS, unavailable)
    public func showAsAlert(withTitle title: String, from viewController: UIViewController?, closeTitle: String = NSLocalizedString("Close", comment: ""), retryTitle: String = NSLocalizedString("Retry", comment: ""), closeHandler: (() -> Void)? = nil, backgroundHandler: ((Error, String) -> Void)? = Self._defaultBackgroundHandler, retryHandler: (() -> Void)?) {
        
        let message = self.localizedDescription
        
        //if the app is in background or the view controller is nil - show local notification
        if UIApplication.shared.applicationState != .active || viewController == nil {
            
            backgroundHandler?(self, title)
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
        
        viewController?.showAlertView(title: title, message: message, actions: actions)
    }
}
#endif
