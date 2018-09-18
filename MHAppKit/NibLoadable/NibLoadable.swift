//
//  NibLoadable.swift
//  MHAppKit
//
//  Created by Milen Halachev on 20.11.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

///A type that can be loaded form a NIB
public protocol NibLoadable {
    
    /**
     Creates an instance of the recevier by loading it from a NIB
    
     - parameter nib: The NIB from which to load the receiver
     - parameter owner: The object to use as the owner of the nib file. If the nib file has an owner, you must specify a valid object for this parameter.
     - parameter options: A dictionary containing the options to use when opening the nib file. For a list of available keys for this dictionary, see NSBundle UIKit Additions.
     - parameter index: The index of the object from the NIB contents. If you specify nil - the first element will be loaded
     
     - returns: An instance of the receiver or nil if an instance of the receiver cannot be found at the specified index.
    */
    init?(nib: UINib, owner: Any?, options: [UINib.OptionsKey: Any]?, at index: Int?)
}

extension NibLoadable {
    
    public init?(nib: UINib, owner: Any?, options: [UINib.OptionsKey: Any]?, at index: Int?) {
        
        let contents = nib.instantiate(withOwner: owner, options: options)
        let object: Self?
        
        if let index = index, contents.count > index {
            
            object = contents[index] as? Self
        }
        else {
            
            object = contents.first as? Self
        }

        guard let result = object else {

            return nil
        }

        self = result
    }
    
    /**
     Creates an instance of the recevier by loading it from a NIB
     
     - parameter name: The name of the nib file, without any leading path information.
     - parameter bundle: The bundle in which to search for the nib file. If you specify nil, this method looks for the nib file in the main bundle.
     - parameter owner: The object to use as the owner of the nib file. If the nib file has an owner, you must specify a valid object for this parameter.
     - parameter options: A dictionary containing the options to use when opening the nib file. For a list of available keys for this dictionary, see NSBundle UIKit Additions.
     - parameter index: The index of the object from the NIB contents. If you specify nil - the first element will be loaded
     
     - returns: An instance of the receiver or nil if an instance of the receiver cannot be found at the specified index.
     
     */
    
    public init?(nibName name: String, bundle: Bundle?, owner: Any?, options: [UINib.OptionsKey: Any]?, at index: Int?) {
        
        let nib = UINib(nibName: name, bundle: bundle)
        self.init(nib: nib, owner: owner, options: options, at: index)
    }
}

extension NibLoadable {
    
    /**
     Loads an instance of the recevier by loading it from a NIB with the name of the receiver's type within the bundle of the receiver's type.
     
     - parameter owner: The object to use as the owner of the nib file. If the nib file has an owner, you must specify a valid object for this parameter.
     - parameter options: A dictionary containing the options to use when opening the nib file. For a list of available keys for this dictionary, see NSBundle UIKit Additions.
     - parameter index: The index of the object from the NIB contents. If you specify nil - the first element will be loaded
     
     - returns: An instance of the receiver or nil if an instance of the receiver cannot be found at the specified index.
     
     */
    
    public static func loadFromNib(owner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil, at index: Int? = nil) -> Self? {
        
        guard let nib = self.loadNib() else {
            
            return nil
        }
        
        return Self(nib: nib, owner: owner, options: options, at: index)
    }
}

extension NibLoadable {
    
    ///Loads a nib with the name of the receiver's type within the bundle of the receiver's type.
    public static func loadNib() -> UINib? {
        
        guard let cls = Self.self as? AnyClass else {
            
            return nil
        }
        
        let name = String(describing: cls)
        let bundle = Bundle(for: cls)
        
        return UINib(nibName: name, bundle: bundle)
    }
}

//makes NSObject conform to NibLoadable
extension NSObject: NibLoadable {
    
}
