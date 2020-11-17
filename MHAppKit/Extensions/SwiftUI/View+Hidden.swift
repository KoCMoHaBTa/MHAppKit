//
//  View+Hidden.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    
    @ViewBuilder func hidden(_ isHidden: Bool) -> some View {
            
        if isHidden {
            
            self.hidden()
        }
        else {
            
            self
        }
    }
    
    @ViewBuilder func visible(_ isVisible: Bool) -> some View {
            
        hidden(!isVisible)
    }
}

