//
//  MFMailComposeViewController+CompletionHandler.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5/31/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

#if canImport(MessageUI)
import Foundation
import MessageUI

extension MFMailComposeViewController: MFMailComposeViewControllerDelegate {
    
    public typealias CompletionHandler = (MFMailComposeViewController, MFMailComposeResult, Error?) -> Void
    
    private static var completionHandlerKey: Void?
    
    ///Makes the MFMailComposeViewController assign itself as delegate and call the provided completionHandler upon completion
    public var completionHandler: CompletionHandler? {
        
        get {
            
            let handler = objc_getAssociatedObject(self, &MFMailComposeViewController.completionHandlerKey) as? CompletionHandler
            return handler
        }
        
        set {
            
            self.mailComposeDelegate = self
            
            objc_setAssociatedObject(self, &MFMailComposeViewController.completionHandlerKey, newValue as Any, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //MARK: - MFMailComposeViewControllerDelegate
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        self.completionHandler?(controller, result, error)
    }
}
#endif
