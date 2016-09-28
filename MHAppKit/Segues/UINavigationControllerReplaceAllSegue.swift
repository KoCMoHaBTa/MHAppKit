//
//  UINavigationControllerReplaceAllSegue.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/13/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

open class UINavigationControllerReplaceAllSegue: UIStoryboardSegue {
    
    open override func perform() {
        
        let source = self.source
        let destination = self.destination
        
        if let navigation = source.navigationController {
            
            let controllers = [destination]
            navigation.setViewControllers(controllers, animated: true)
        }
    }
}
