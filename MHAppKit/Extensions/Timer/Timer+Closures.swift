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
    
    public convenience init(timeInterval: TimeInterval, repeats: Bool, handler: @escaping Handler) {
        
        if #available(iOS 10.0, *) {
            
            self.init(timeInterval: timeInterval, repeats: repeats, block: handler)
        }
        else {
            
            self.init(timeInterval: timeInterval, target: Timer.self, selector: #selector(Timer.timerHandler(_:)), userInfo: handler as Any, repeats: repeats)
        }
    }
    
    public class func scheduledTimer(withTimeInterval timeInterval: TimeInterval, repeats: Bool, handler: @escaping Handler) -> Timer {
        
        if #available(iOS 10.0, *) {
            
            return self.scheduledTimer(withTimeInterval: timeInterval, repeats: repeats, block: handler)
        }
        else {
            
            return self.scheduledTimer(timeInterval: timeInterval, target: Timer.self, selector: #selector(Timer.timerHandler(_:)), userInfo: handler as Any, repeats: repeats)
        }
    }
    
    private dynamic class func timerHandler(_ timer: Timer) {
        
        (timer.userInfo as? Handler)?(timer)
    }
}
