//
//  DynamicSizeTableSuplementaryView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5/14/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

/**
 
 This class is intended to represent self-sizing UITableView's header or footer.
 
 In order to achieve the self-sizing behaviour you should:
 - set tableView reference
 - set contentView reference
 - set contentView constraints that makes the contentView self-sizing, but not limiting its size to the parent size.
 - provide layout behaviour by either setting the `didLayoutContentViewHandler` or overriding `didLayoutContentView`
 
 For example set only left, top and right constraints of ContentView related to superview in order to achieve dynamic height that grows down.
 You can use the predefined `DynamicSizeTableHeaderView` and `DynamicSizeTableFooterView`
 
 */

open class DynamicSizeTableSuplementaryView: UIView {
    
    @IBOutlet open weak var tableView: UITableView?
    @IBOutlet open weak var contentView: UIView?
    
    lazy var didLayoutContentViewHandler: (() -> Void)? = { [unowned self] () -> Void in
        
        print("Unhandled layout behaviour for \(self)")
    }
    
    open override func layoutSubviews() {
        
        if !ProcessInfo().isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 8, minorVersion: 4, patchVersion: 0)) {
            
            super.layoutSubviews()
        }
        
        if let contentView = self.contentView {
            
            contentView.setNeedsDisplay()
            contentView.layoutIfNeeded()
            
            self.bounds.size.height = contentView.bounds.size.height
            
            self.didLayoutContentView()
            
        }
        
        if ProcessInfo().isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 8, minorVersion: 4, patchVersion: 0)) {
            
            super.layoutSubviews()
        }
    }
    
    open func didLayoutContentView() {
        
        self.didLayoutContentViewHandler?()
    }
}
#endif
