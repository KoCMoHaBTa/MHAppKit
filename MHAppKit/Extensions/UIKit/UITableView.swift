//
//  UITableView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 21.11.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    public func indexPaths(for event: UIEvent) -> [IndexPath] {
        
        return event.allTouches?.reduce([], { (result, touch) -> [IndexPath] in
            
            guard let indexPath = self.indexPathForRow(at: touch.location(in: self)) else {
                
                return result
            }
            
            return result + indexPath
            
        }) ?? []
    }
}

