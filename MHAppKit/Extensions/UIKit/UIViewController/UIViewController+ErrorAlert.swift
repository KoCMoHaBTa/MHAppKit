//
//  UIViewController+ErrorAlert.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.09.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit
import UserNotifications

@available(tvOS 10.0, *)
extension UIViewController {
        
    /**
    Shows an alert representation of a given error within the receiver's context. If the alert is presented withing a background state - a local notification is also shown.
    
    - parameter error: The error to show. If nil, no error will be shown. This parameter is optional for convenience.
    - parameter title: The alert title.
    - parameter closeTitle: The title of the close button of the alert. Default to `NSLocalizedString("Close", comment: "")`.
    - parameter retryTitle: The title of the retry button of the alert. Default to `NSLocalizedString("Retry", comment: "")`.
    - parameter backgroundHandler: An optional handler, executed if the alert is gong to be shown, when the app is in the background. Default to showing the error as a local notification.
    - parameter closeHandler: An optional close handler. Default to `nil`.
    - parameter retryHandler: An optional retry handler. If `nil`, no retry option is presented.
    */
    
    @available(tvOS, unavailable)
    public func showError(_ error: Error?, title: String, closeTitle: String = NSLocalizedString("Close", comment: ""), retryTitle: String = NSLocalizedString("Retry", comment: ""), closeHandler: (() -> Void)? = nil, backgroundHandler: ((Error, String) -> Void)? = NSError._defaultBackgroundHandler, retryHandler: (() -> Void)?) {
        
        error?.showAsAlert(withTitle: title, from: self, closeTitle: closeTitle, retryTitle: retryTitle, closeHandler: closeHandler, backgroundHandler: backgroundHandler, retryHandler: retryHandler)
    }
}
#endif
