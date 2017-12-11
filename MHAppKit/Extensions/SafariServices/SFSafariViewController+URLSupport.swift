//
//  SFSafariViewController+URLSupport.swift
//  MHAppKit
//
//  Created by Milen Halachev on 11.12.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import SafariServices

@available(iOS 9.0, *)
extension SFSafariViewController {
    
    public static func isURLSupported(_ url: URL?) -> Bool {
        
        return url?.scheme?.lowercased() == "http"
            || url?.scheme?.lowercased() == "https"
    }
}
