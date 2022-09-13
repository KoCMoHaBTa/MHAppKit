//
//  UIResponder.swift
//  MHAppKit
//
//  Created by Milen Halachev on 25.01.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

extension UIResponder {

    public var responderChain: AnySequence<UIResponder> {
        
        return AnySequence.init { [weak self] () -> AnyIterator<UIResponder> in
            
            var current: UIResponder? = self
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
    
    public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        for responder in self {
            
            if responder.canPerformAction(action, withSender: sender) {
                
                return true
            }
        }
        
        return false
    }
}
#endif
