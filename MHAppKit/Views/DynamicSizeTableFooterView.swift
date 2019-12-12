//
//  DynamicSizeTableFooterView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5/14/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

open class DynamicSizeTableFooterView: DynamicSizeTableSuplementaryView {
    
    open override func didLayoutContentView() {
        
        self.tableView?.tableFooterView = self
    }
}
#endif
