//
//  TimeInterval+TimeConvertion.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/24/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    public init(seconds: Int) {
        
        self.init(seconds)
    }
    
    public init(minutes: Int) {
        
        //1 min is 60 seconds
        self.init(seconds: 60 * minutes)
    }
    
    public init(hours: Int) {
        
        //1 htour is 60 minutes
        self.init(minutes: 60 * hours)
    }
    
    public init(days: Int) {
        
        //1 day is 24 hours
        self.init(hours: 24 * days)
    }
    
    public init(weeks: Int) {
        
        //1 week is 7 days
        self.init(days: 7 * weeks)
    }
}
