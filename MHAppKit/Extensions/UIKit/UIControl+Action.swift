//
//  UIControl+Action.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5/30/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

extension UIControl {
    
    public typealias Action = (_ sender: UIControl) -> Void
    
    ///Adds an action handler to the receiver for the given `UIControlEvents` (default to `.touchUpInside`)
    public func addAction(forEvents events: UIControlEvents = [.touchUpInside], action: @escaping Action) {
        
        //the action should be called for every event
        let handler = ActionHandler(control: self, events: events, action: action)
        self.actionHandlers.append(handler)
    }
    
    ///Returns an array of actions added to the receiver for the given control events
    public func actions(forEvents events: UIControlEvents) -> [Action] {
        
        return self.actionHandlers.filter({ $0.events.contains(events) }).map({ $0.action })
    }
    
    ///removes all actions from the receiver for the given control events
    public func removeActions(forEvents events: UIControlEvents) {
        
        self.actionHandlers = self.actionHandlers.filter({ !$0.events.contains(events) })
    }
}

extension UIControl {
    
    private static var actionHandlersKey = ""
    fileprivate var actionHandlers: [ActionHandler] {
        
        get {
            
            let result = objc_getAssociatedObject(self, &UIControl.actionHandlersKey) as? [ActionHandler] ?? []
            return result
        }
        
        set {

            let newValue = newValue.filter({ $0.control != nil })
            objc_setAssociatedObject(self, &UIControl.actionHandlersKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIControl {
    
    fileprivate class ActionHandler {
        
        weak var control: UIControl?
        let events: UIControlEvents
        let action: Action
        
        deinit {
            
            self.control?.removeTarget(self, action: #selector(handleAction(_:)), for: self.events)
        }
        
        init(control: UIControl, events: UIControlEvents, action: @escaping Action) {
            
            self.control = control
            self.events = events
            self.action = action
            
            control.addTarget(self, action: #selector(handleAction(_:)), for: events)
        }
        
        dynamic func handleAction(_ sender: UIControl) {
            
            self.action(sender)
        }
    }
}