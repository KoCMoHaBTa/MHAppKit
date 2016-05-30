//
//  UIButton.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5/30/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    public convenience init(text: String?) {
        
        self.init()
        
        self.setTitle(text, forState: .Normal)
    }
    
    public convenience init(text: String?, textAlignment: NSTextAlignment) {
        
        self.init(text: text)
        
        self.titleLabel?.textAlignment = textAlignment
    }
    
    public convenience init(image: UIImage?) {
        
        self.init()
        
        self.setImage(image, forState: .Normal)
    }
}