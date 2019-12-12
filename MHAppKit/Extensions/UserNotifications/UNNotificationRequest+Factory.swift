//
//  UNNotificationRequest+Factory.swift
//  MHAppKit
//
//  Created by Milen Halachev on 28.06.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation
import UserNotifications

@available(watchOS 3.0, *)
@available(tvOS 10.0, *)
@available(OSX 10.14, *)
@available(iOS 10.0, *)
extension UNNotificationRequest {
    
    ///Creates and instance of the receiver with given content, UUID for identifier and nil trigger
    public convenience init(content: UNNotificationContent) {
        
        self.init(identifier: .uuid, content: content, trigger: nil)
    }
}
