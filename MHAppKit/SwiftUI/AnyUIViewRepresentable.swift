//
//  AnyUIViewRepresentable.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
public struct AnyUIViewRepresentable<UIViewType: UIView, Coordinator>: UIViewRepresentable {
    
    private let _makeUIView: (Context) -> UIViewType
    private let _updateUIView: (UIViewType, Context) -> Void
    private let _makeCoordinator: () -> Coordinator
    
    public init(makeUIView: @escaping (Context) -> UIViewType, updateUIView: @escaping (UIViewType, Context) -> Void, makeCoordinator: @escaping () -> Coordinator) {
        
        _makeUIView = makeUIView
        _updateUIView = updateUIView
        _makeCoordinator = makeCoordinator
    }
    
    public func makeUIView(context: Context) -> UIViewType {
        
        return _makeUIView(context)
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        
        _updateUIView(uiView, context)
    }
    
    public func makeCoordinator() -> Coordinator {
        
        return _makeCoordinator()
    }
}

@available(iOS 13.0, tvOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
extension AnyUIViewRepresentable where Coordinator == Void {
    
    public init(makeUIView: @escaping (Context) -> UIViewType, updateUIView: @escaping (UIViewType, Context) -> Void = { _,_ in }) {
        
        self.init(
            makeUIView: makeUIView,
            updateUIView: updateUIView,
            makeCoordinator: {()}
        )
    }
}
