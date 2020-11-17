//
//  View+Conditional.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation
import SwiftUI

//Based on https://fivestars.blog/swiftui/conditional-modifiers.html
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    
  @ViewBuilder
  func `if`<T: View>(_ condition: Bool, @ViewBuilder transform: (Self) -> T) -> some View {
    
    if condition {
        
        transform(self)
    }
    else {
        
      self
    }
  }
}
