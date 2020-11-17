//
//  View+Map.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    
    @ViewBuilder
    public func map<T: View>(@ViewBuilder _ transform: (Self) -> T) -> some View  {
    
        transform(self)
    }
}

