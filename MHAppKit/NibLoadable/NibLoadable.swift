//
//  NibLoadable.swift
//  MHAppKit
//
//  Created by Milen Halachev on 20.11.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

protocol NibLoadable {
    
    init?(nibName: String, bundle: Bundle?, owner: Any?, options: [AnyHashable: Any]?)
}

extension NibLoadable {
    
    public init?(nibName: String, bundle: Bundle?, owner: Any?, options: [AnyHashable: Any]?) {
        
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let object = nib.instantiate(withOwner: owner, options: options).first as? Self else {
            
            return nil
        }
        
        self = object
    }
    
    public static func loadFromNib(withName name: String, bundle: Bundle?, owner: Any?, options: [AnyHashable: Any]?) -> Self? {
        
        return Self(nibName: name, bundle: bundle, owner: owner, options: options)
    }
    
    public static func loadFromNib(owner: Any? = nil, options: [AnyHashable: Any]? = nil) -> Self? {
        
        guard let cls = Self.self as? AnyClass else {
            
            return nil
        }
        
        let name = String(describing: cls)
        let bundle = Bundle(for: cls)
        
        return self.loadFromNib(withName: name, bundle: bundle, owner: owner, options: options)
    }
}

extension NSObject: NibLoadable {
    
}
