//
//  UIApplication+OpenSettings.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

extension UIApplication {
    
    @available(iOS 10.0, tvOS 10.0, *)
    func openSettings() {
        
        self.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
}
#endif
