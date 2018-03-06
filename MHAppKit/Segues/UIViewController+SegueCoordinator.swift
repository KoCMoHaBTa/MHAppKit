//
//  UIViewController+SegueCoordinator.swift
//  MHAppKit
//
//  Created by Milen Halachev on 10/18/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension UIViewController {
    
    private static var segueCoordinatorKey = ""
    
    ///The segue coordinator associated with the receiver - default to the shared instance `SegueCoordinator.default`
    open var segueCoordinator: SegueCoordinator {
        
        get {
            
            return objc_getAssociatedObject(self, &UIViewController.segueCoordinatorKey) as? SegueCoordinator ?? .default
        }
        
        set {
            
            objc_setAssociatedObject(self, &UIViewController.segueCoordinatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private static var temporarySegueCoordinatorKey = ""
    
    ///An additional, temporary, one time usable segue coordinator. Once it is used, its reference is set to nil. Can be used to fine tune next segue. Used in condjuction with `performSegue(withIdentifier:sender:prepareHandler)`
    open var temporarySegueCoordinator: SegueCoordinator? {
        
        get {
            
            return objc_getAssociatedObject(self, &UIViewController.temporarySegueCoordinatorKey) as? SegueCoordinator
        }
        
        set {
            
            objc_setAssociatedObject(self, &UIViewController.temporarySegueCoordinatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    ///Calls `self.segueCoordinator.prepare(for: segue, sender: sender)`. This method is used for objc compatibility
    @objc open dynamic func prepare(usingCoordinatorFor segue: UIStoryboardSegue, sender: Any?) {
     
        self.segueCoordinator.prepare(for: segue, sender: sender)
        self.temporarySegueCoordinator?.prepare(for: segue, sender: sender)
        self.temporarySegueCoordinator = nil
    }
    
    ///Performs a segue by providing a prepare handler for setting up a one time usable temporray SegueCoordinator
    public func performSegue(withIdentifier identifier: String, sender: Any?, prepareHandler: (SegueCoordinator) -> Void) {
        
        let temporarySegueCoordinator = SegueCoordinator()
        prepareHandler(temporarySegueCoordinator)
        self.temporarySegueCoordinator = temporarySegueCoordinator
        
        self.performSegue(withIdentifier: identifier, sender: sender)
    }
    
    ///Performs a segue by providing a single one time context handler for setting up dependencies from a given source to a given destination
    public func performSegue<Source, Destination>(withIdentifier identifier: String, sender: Any?, contextHandler: @escaping (Source, Destination) -> Void) {
        
        self.performSegue(withIdentifier: identifier, sender: sender) { (coordinator) in
            
            coordinator.addPrepareHandler({ (source, destination) in
                
                destination.temporarySegueCoordinator = source.temporarySegueCoordinator
            })
            
            coordinator.addContextHandler({ (source: Source, destination: Destination) in
                
                contextHandler(source, destination)
                (destination as? UIViewController)?.temporarySegueCoordinator = nil
            })
        }
    }
}
