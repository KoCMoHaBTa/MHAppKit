//
//  NibLoadable.swift
//  MHAppKit
//
//  Created by Milen Halachev on 20.11.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

public protocol NibLoadable {
    
    init?(nibName: String, bundle: Bundle?, owner: Any?, options: [AnyHashable: Any]?, at index: Int?)
}

extension NibLoadable {
    
    public init?(nibName: String, bundle: Bundle?, owner: Any?, options: [AnyHashable: Any]?, at index: Int?) {
        
        let nib = UINib(nibName: nibName, bundle: bundle)
        let contents = nib.instantiate(withOwner: owner, options: options)
        guard let object = index == nil ? contents.first as? Self : contents[index!] as? Self else {
            
            return nil
        }
        
        self = object
    }
    
    public static func loadFromNib(withName name: String, bundle: Bundle?, owner: Any?, options: [AnyHashable: Any]?, at index: Int?) -> Self? {
        
        return Self(nibName: name, bundle: bundle, owner: owner, options: options, at: index)
    }
    
    public static func loadFromNib(owner: Any? = nil, options: [AnyHashable: Any]? = nil, at index: Int? = nil) -> Self? {
        
        guard let cls = Self.self as? AnyClass else {
            
            return nil
        }
        
        let name = String(describing: cls)
        let bundle = Bundle(for: cls)
        
        return self.loadFromNib(withName: name, bundle: bundle, owner: owner, options: options, at: index)
    }
}

extension NSObject: NibLoadable {
    
}
