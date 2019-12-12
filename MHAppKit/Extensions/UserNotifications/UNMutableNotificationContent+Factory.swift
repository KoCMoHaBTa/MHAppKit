//
//  UNMutableNotificationContent+Factory.swift
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
extension UNMutableNotificationContent {
    
    ///Creates and instance of the receiver with a given title, optional subtitle and body and default sound
    @available(tvOS, unavailable)
    public convenience init(title: String, subtitle: String? = nil, body: String? = nil, sound: UNNotificationSound? = .default) {
        
        self.init()
        
        self.title = title
        
        if let subtitle = subtitle {
            
            self.subtitle = subtitle
        }
        
        if let body = body {
            
            self.body = body
        }
        
        self.sound = sound
    }
    
    ///Creates and instance of the receiver with a given title, body and default sound
    @available(tvOS, unavailable)
    public convenience init(title: String, body: String) {
        
        self.init(title: title, subtitle: nil, body: body, sound: .default)
    }
}
