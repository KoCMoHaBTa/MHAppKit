//
//  UILabel.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    ///Creates an instance of the receiver with a given text.
    public convenience init(text: String) {
        
        self.init()
        self.text = text
        self.sizeToFit()
    }
}
