//
//  MFMailComposeViewController+CompletionHandler.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5/31/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import MessageUI

extension MFMailComposeViewController: MFMailComposeViewControllerDelegate {
    
    public typealias CompletionHandler = (controller: MFMailComposeViewController, result: MFMailComposeResult, error: NSError?) -> Void
    
    private static var completionHandlerKey = ""
    
    public var completionHandler: CompletionHandler? {
        
        get {
            
            return (objc_getAssociatedObject(self, &MFMailComposeViewController.completionHandlerKey) as? CompletionHandlerWrapper)?.handler
        }
        
        set {
            
            self.mailComposeDelegate = self
            
            objc_setAssociatedObject(self, &MFMailComposeViewController.completionHandlerKey, CompletionHandlerWrapper(newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        self.completionHandler?(controller: controller, result: result, error: error)
    }
}

extension MFMailComposeViewController {
    
    private class CompletionHandlerWrapper {
        
        let handler: MFMailComposeViewController.CompletionHandler
        
        init?(_ handler: MFMailComposeViewController.CompletionHandler?) {
            
            guard let handler = handler else { return nil }
            
            self.handler = handler
        }
    }
}