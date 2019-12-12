//
//  UIVIew+Chaining.swift
//  MHAppKit
//
//  Created by Milen Halachev on 27.09.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

extension UIView {
    
    public func addingSubview(_ subview: UIView) -> Self {
        
        self.addSubview(subview)
        return self
    }
}
#endif
