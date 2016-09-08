//
//  UINavigationControllerReplaceLastSegue.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/13/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

open class UINavigationControllerReplaceLastSegue: UIStoryboardSegue {
   
    open override func perform() {
        
        let source = self.source
        let destination = self.destination
        
        if let navigation = source.navigationController {
            
            var controllers = navigation.viewControllers
            controllers.removeLast()
            controllers.append(destination)
            
            navigation.setViewControllers(controllers, animated: true)
        }
    }
}
