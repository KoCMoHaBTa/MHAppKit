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
    
    public typealias CompletionHandler = (_ controller: MFMailComposeViewController, _ result: MFMailComposeResult, _ error: NSError?) -> Void
    
    private static var completionHandlerKey = ""
    public var completionHandler: CompletionHandler? {
        
        get {
            
            let obj = objc_getAssociatedObject(self, &MFMailComposeViewController.completionHandlerKey)
            let wrapper = obj as? CompletionHandlerWrapper
            let handler = wrapper?.handler
            
            return handler
        }
        
        set {
            
            self.mailComposeDelegate = self
            
            let handler = newValue
            let wrapper = CompletionHandlerWrapper(handler: handler)
            
            objc_setAssociatedObject(self, &MFMailComposeViewController.completionHandlerKey, wrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        self.completionHandler?(controller, result, error as NSError?)
    }
}

extension MFMailComposeViewController {
    
    fileprivate class CompletionHandlerWrapper {
        
        let handler: MFMailComposeViewController.CompletionHandler?
        
        init(handler: MFMailComposeViewController.CompletionHandler?) {
            
            self.handler = handler
        }
    }
}
