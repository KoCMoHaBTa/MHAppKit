//
//  TimeInterval+TimeConvertion.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/24/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    init(seconds: Int) {
        
        self.init(seconds)
    }
    
    init(minutes: Int) {
        
        //1 min is 60 seconds
        self.init(seconds: 60 * minutes)
    }
    
    init(hours: Int) {
        
        //1 htour is 60 minutes
        self.init(minutes: 60 * hours)
    }
    
    init(days: Int) {
        
        //1 day is 24 hours
        self.init(hours: 24 * days)
    }
    
    init(weeks: Int) {
        
        //1 week is 7 days
        self.init(days: 7 * weeks)
    }
}
