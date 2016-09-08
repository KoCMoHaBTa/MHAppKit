//
//  ViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/12/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

open class ViewController: UIViewController, UINavigationControllerPreferencesProvider {
    
    open var prefersStatusBarHiddenValue: Bool?
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    open override var prefersStatusBarHidden : Bool {
        
        return self.prefersStatusBarHiddenValue ?? super.prefersStatusBarHidden
    }
    
    //MARK: - UINavigationControllerPreferencesProvider
    
    @IBInspectable open var providesNavigationControllerPreferencesIB: Bool = false
    @IBInspectable open var prefersNavigationBarHiddenIB: Bool = false
    
    open func providesNavigationControllerPreferences() -> Bool {
        
        return self.providesNavigationControllerPreferencesIB
    }
    
    open func prefersNavigationBarHidden() -> Bool {
        
        return self.prefersNavigationBarHiddenIB
    }
}

