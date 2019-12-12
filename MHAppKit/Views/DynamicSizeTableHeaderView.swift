//
//  DynamicSizeTableHeaderView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5/14/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

open class DynamicSizeTableHeaderView: DynamicSizeTableSuplementaryView {
    
    open override func didLayoutContentView() {
        
        self.tableView?.tableHeaderView = self
    }
}
#endif
