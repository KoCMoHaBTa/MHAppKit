//
//  ViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/12/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

public class ViewController: UIViewController, UINavigationControllerPreferencesProvider {
    
    public var prefersStatusBarHiddenValue: Bool?
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    public override func prefersStatusBarHidden() -> Bool {
        
        return self.prefersStatusBarHiddenValue ?? super.prefersStatusBarHidden()
    }
    
    //MARK: - UINavigationControllerPreferencesProvider
    
    @IBInspectable public var providesNavigationControllerPreferencesIB: Bool = false
    @IBInspectable public var prefersNavigationBarHiddenIB: Bool = false
    
    public func providesNavigationControllerPreferences() -> Bool {
        
        return self.providesNavigationControllerPreferencesIB
    }
    
    public func prefersNavigationBarHidden() -> Bool {
        
        return self.prefersNavigationBarHiddenIB
    }
}

