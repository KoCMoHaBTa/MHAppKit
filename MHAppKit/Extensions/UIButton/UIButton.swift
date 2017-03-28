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
    
    ///Creates an instance of the receiver with a given text for normal state.
    public convenience init(text: String?) {
        
        self.init()
        
        self.setTitle(text, for: .normal)
    }
    
    ///Creates an instance of the receiver with a given text for normal state and text alignment
    public convenience init(text: String?, textAlignment: NSTextAlignment) {
        
        self.init(text: text)
        
        self.titleLabel?.textAlignment = textAlignment
    }
    
    ///Creates an instance of the receiver with a given image for normal state.
    public convenience init(image: UIImage?) {
        
        self.init()
        
        self.setImage(image, for: .normal)
    }
}
