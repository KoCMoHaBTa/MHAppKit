//
//  PassthroughView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 14.08.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

//https://medium.com/@nguyenminhphuc/how-to-pass-ui-events-through-views-in-ios-c1be9ab1626b
open class PassthroughView: UIView {
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}
