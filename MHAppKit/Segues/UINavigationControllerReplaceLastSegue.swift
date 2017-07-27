//
//  UINavigationControllerReplaceLastSegue.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/13/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

///A segue that replaces the last view controller of the source's navigation stack with the destination
open class UINavigationControllerReplaceLastSegue: UIStoryboardSegue {
   
    open var animated = true
    
    open override func perform() {
        
        let source = self.source
        let destination = self.destination
        
        if let navigation = source.navigationController {
            
            var controllers = navigation.viewControllers
            controllers.removeLast()
            controllers.append(destination)
            
            navigation.setViewControllers(controllers, animated: self.animated)
        }
    }
}
