//
//  SegueCoordinator.swift
//  MHAppKit
//
//  Created by Milen Halachev on 10/18/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension SegueCoordinator {
    
    fileprivate struct PrepareHandler {
        
        private let handler: (UIStoryboardSegue, Sender?) -> Void
        
        init(handler: @escaping (UIStoryboardSegue, Sender?) -> Void) {
            
            self.handler = handler
        }
        
        func prepare(for segue: UIStoryboardSegue, sender: Sender?) {
            
            self.handler(segue, sender)
        }
    }
}

extension SegueCoordinator {
    
    ///A default shared instance of SegueCoordinator
    public static let `default` = SegueCoordinator()
}

open class SegueCoordinator {
    
    ///The underlaying storage of all prepare handlers
    fileprivate var prepareHandlers: [PrepareHandler] = []
}

//MARK: - Preparing Segues

extension SegueCoordinator {
     
    ///Prepares a segue's source and destination based on all stored handlers. Also updates the destination `segueCoordinator` reference
    open func prepare(for segue: UIStoryboardSegue, sender: Sender?) {
        
        //associate the coordinator with the destination
        segue.destination.segueCoordinator = segue.source.segueCoordinator
        
        //try to find an instance of SeguePrepareHandler based on any combination of criterias, like segue identifier, source, destination, sender
        self.prepareHandlers.forEach { (handler) in
            
            handler.prepare(for: segue, sender: sender)
        }
    }
}

//MARK: - Adding Prepare Handlers

extension SegueCoordinator {
    
    public typealias Identifier = String
    public typealias Sender = Any
    
    private func _addPrepareHandler<Source, Destination>(_ handler: @escaping (Identifier?, Source, Destination, Sender?) -> Void) {
        
        let seguePrepareHandler = PrepareHandler { (segue, sender) in
            
            func lookup<T>(controller: UIViewController, ofType type: T.Type) -> T? {
                
                if let controller = controller as? T {
                    
                    return controller
                }
                
                if controller.childViewControllers.count == 1,
                let child = controller.childViewControllers.first as? T {
                
                    return child
                }
                
                return nil
            }
            
            guard
            let source = lookup(controller: segue.source, ofType: Source.self),
            let destination = lookup(controller: segue.destination, ofType: Destination.self)
            else {
                
                return
            }
            
            let identifier = segue.identifier
            
            handler(identifier, source, destination, sender)
        }
        
        self.prepareHandlers.append(seguePrepareHandler)
    }
    
    ///Adds a prepare handler for Any Source and Any Destination
    public func addPrepareHandler<Source, Destination>(_ handler: @escaping (Identifier?, Source, Destination, Sender?) -> Void) {
        
        _addPrepareHandler(handler)
    }
    
    ///Adds a prepare handler for UIViewController Source and UIViewController Destination
    public func addPrepareHandler<Source, Destination>(_ handler: @escaping (Identifier?, Source, Destination, Sender?) -> Void)
    where Source: UIViewController, Destination: UIViewController {
        
        _addPrepareHandler(handler)
    }
    
    ///Adds a prepare handler for Any Source and UIViewController Destination
    public func addPrepareHandler<Source, Destination>(_ handler: @escaping (Identifier?, Source, Destination, Sender?) -> Void)
    where Destination: UIViewController {
        
        _addPrepareHandler(handler)
    }
    
    ///Adds a prepare handler for UIViewController Source and Any Destination
    public func addPrepareHandler<Source, Destination>(_ handler: @escaping (Identifier?, Source, Destination, Sender?) -> Void)
    where Source: UIViewController {
        
        _addPrepareHandler(handler)
    }
}

extension SegueCoordinator {
    
    ///Adds a prepare handler for Any Source and Any Destination
    public func addPrepareHandler<Source, Destination>(_ handler: @escaping (Source, Destination) -> Void) {
        
        self.addPrepareHandler { (_, source: Source, destination: Destination, _) in
            
            handler(source, destination)
        }
    }
    
    ///Adds a prepare handler for UIViewController Source and UIViewController Destination
    public func addPrepareHandler<Source, Destination>(_ handler: @escaping (Source, Destination) -> Void)
    where Source: UIViewController, Destination: UIViewController {
        
        self.addPrepareHandler { (_, source: Source, destination: Destination, _) in
            
            handler(source, destination)
        }
    }
    
    ///Adds a prepare handler for Any Source and UIViewController Destination
    public func addPrepareHandler<Source, Destination>(_ handler: @escaping (Source, Destination) -> Void)
    where Destination: UIViewController {
        
        self.addPrepareHandler { (_, source: Source, destination: Destination, _) in
            
            handler(source, destination)
        }
    }
    
    ///Adds a prepare handler for UIViewController Source and Any Destination
    public func addPrepareHandler<Source, Destination>(_ handler: @escaping (Source, Destination) -> Void)
    where Source: UIViewController {
        
        self.addPrepareHandler { (_, source: Source, destination: Destination, _) in
            
            handler(source, destination)
        }
    }
}

//MARK: - Context Handlers

extension SegueCoordinator {
 
    ///Adds a context handler to the receiver. A context handler is such handler that will be applied to any combination of relationship between source and destination. 
    ///For example if you present 5 screens - a context handler can be used to resolve dependencies between the first and the last one.
    public func addContextHandler<Source, Destination>(_ handler: @escaping (Source, Destination) -> Void)
    where Source: AnyObject {
                
        weak var weakSource: Source? = nil
        
        self.addPrepareHandler { (_, source: Source, _, _) in
         
            weakSource = source
        }
        
        self.addPrepareHandler { (_, _, destination: Destination, _) in
            
            if let source = weakSource {
                
                handler(source, destination)
            }
        }
    }
}

