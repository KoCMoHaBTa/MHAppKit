//
//  AnyUIViewControllerRepresentable.swift
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
public struct AnyUIViewControllerRepresentable<UIViewControllerType: UIViewController, Coordinator>: UIViewControllerRepresentable {
    
    private let _makeUIViewController: (Context) -> UIViewControllerType
    private let _updateUIViewController: (UIViewControllerType, Context) -> Void
    private let _makeCoordinator: () -> Coordinator
    
    public init(makeUIViewController: @escaping (Context) -> UIViewControllerType, updateUIViewController: @escaping (UIViewControllerType, Context) -> Void, makeCoordinator: @escaping () -> Coordinator) {
        
        _makeUIViewController = makeUIViewController
        _updateUIViewController = updateUIViewController
        _makeCoordinator = makeCoordinator
    }
    
    public func makeUIViewController(context: Context) -> UIViewControllerType {
        
        return _makeUIViewController(context)
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        _updateUIViewController(uiViewController, context)
    }
    
    public func makeCoordinator() -> Coordinator {
        
        return _makeCoordinator()
    }
}

@available(iOS 13.0, tvOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
extension AnyUIViewControllerRepresentable where Coordinator == Void {
    
    public init(makeUIViewController: @escaping (Context) -> UIViewControllerType, updateUIViewController: @escaping (UIViewControllerType, Context) -> Void = { _,_ in }) {
        
        self.init(
            makeUIViewController: makeUIViewController,
            updateUIViewController: updateUIViewController,
            makeCoordinator: {()}
        )
    }
}

