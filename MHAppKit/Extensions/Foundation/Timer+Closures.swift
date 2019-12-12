//
//  Timer+Closures.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5/26/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension Timer {
    
    public typealias Handler = (Timer) -> Void
    
    ///Createas an instance of the receiver initialized with a handler closure when executed
    public convenience init(timeInterval: TimeInterval, repeats: Bool, handler: @escaping Handler) {
        
        if #available(iOS 10.0, *), #available(OSX 10.12, *), #available(tvOS 10.0, *), #available(watchOS 3.0, *) {
            
            self.init(timeInterval: timeInterval, repeats: repeats, block: handler)
        }
        else {
            
            self.init(timeInterval: timeInterval, target: Timer.self, selector: #selector(Timer.timerHandler(_:)), userInfo: handler as Any, repeats: repeats)
        }
    }
    
    ///Creates and returns a new NSTimer object and schedules it on the current run loop in the default mode. The provided handler will be executed.
    public class func scheduledTimer(withTimeInterval timeInterval: TimeInterval, repeats: Bool, handler: @escaping Handler) -> Timer {
        
        if #available(iOS 10.0, *), #available(OSX 10.12, *), #available(tvOS 10.0, *), #available(watchOS 3.0, *) {
            
            return self.scheduledTimer(withTimeInterval: timeInterval, repeats: repeats, block: handler)
        }
        else {
            
            return self.scheduledTimer(timeInterval: timeInterval, target: Timer.self, selector: #selector(Timer.timerHandler(_:)), userInfo: handler as Any, repeats: repeats)
        }
    }
    
    @objc private dynamic class func timerHandler(_ timer: Timer) {
        
        (timer.userInfo as? Handler)?(timer)
    }
}
