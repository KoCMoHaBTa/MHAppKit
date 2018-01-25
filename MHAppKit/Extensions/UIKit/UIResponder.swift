//
//  UIResponder.swift
//  MHAppKit
//
//  Created by Milen Halachev on 25.01.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {

    var responderChain: AnySequence<UIResponder> {
        
        return AnySequence.init { () -> AnyIterator<UIResponder> in
            
            weak var current: UIResponder? = self
            return AnyIterator.init({ () -> UIResponder? in

                defer {
                    
                    current = current?.next
                }
                
                return current
            })
        }
    }
}

extension Sequence where Element: UIResponder {
    
    func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        for responder in self {
            
            if responder.canPerformAction(action, withSender: sender) {
                
                return true
            }
        }
        
        return false
    }
}
