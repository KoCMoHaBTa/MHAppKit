//
//  TableView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.10.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
open class TableView: UITableView {
    
    @IBInspectable open var autosize: Bool = false
    
    open override var intrinsicContentSize: CGSize {
        
        return self.autosize ? self.contentSize : super.intrinsicContentSize
    }
}
