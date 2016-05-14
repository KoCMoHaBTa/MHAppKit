//
//  DynamicSizeTableHeaderView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5/14/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

public class DynamicSizeTableHeaderView: DynamicSizeTableSuplementaryView {
    
    public override func didLayoutContentView() {
        
        self.tableView?.tableHeaderView = self
    }
}