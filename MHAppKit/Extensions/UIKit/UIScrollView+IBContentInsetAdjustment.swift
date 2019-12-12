//
//  UIScrollView+IBContentInsetAdjustment.swift
//  MHAppKit
//
//  Created by Milen Halachev on 19.08.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

extension UIScrollView {

    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    @IBInspectable public var automaticallyAdjustsContentInset: Bool {
        
        get {
            
            return self.contentInsetAdjustmentBehavior != .never
        }
        set {
            
            self.contentInsetAdjustmentBehavior = newValue ? .automatic : .never
        }
    }
}
#endif
