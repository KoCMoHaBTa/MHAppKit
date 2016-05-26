//
//  NSTimer+Closures.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5/26/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NSTimer {
    
    public typealias Handler = (timer: NSTimer) -> Void
    
    private class HandlerWrapper {
        
        let handler: Handler
        
        init(_ handler: Handler) {
            
            self.handler = handler
        }
    }
    
    public convenience init(timeInterval: NSTimeInterval, repeats: Bool, handler: Handler) {
        
        self.init(timeInterval: timeInterval, target: NSTimer.self, selector: #selector(NSTimer.timerHandler(_:)), userInfo: HandlerWrapper(handler), repeats: repeats)
    }
    
    public class func scheduledTimerWithTimeInterval(timeInterval: NSTimeInterval, repeats: Bool, handler: Handler) -> NSTimer {
        
        return self.scheduledTimerWithTimeInterval(timeInterval, target: NSTimer.self, selector: #selector(NSTimer.timerHandler(_:)), userInfo: HandlerWrapper(handler), repeats: repeats)
    }
    
    private dynamic class func timerHandler(timer: NSTimer) {
        
        (timer.userInfo as? HandlerWrapper)?.handler(timer: timer)
    }
}