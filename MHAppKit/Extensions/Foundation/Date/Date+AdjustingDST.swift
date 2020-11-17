//
//  Date+AdjustingDST.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

extension Date {
    
    /**
     Adjusts the DST to match a given date in a specific time zone.
     - parameter timeZone: The time zone for wich to adjust the DST
     - parameter date: The date in regards to which to match the DST
     - returns: The adjusted date.
     */
    public func adjustingDaylightSavingTime(for timeZone: TimeZone = .current, inRegardsTo date: Date = Date()) -> Date {
        
        //if today is DST, but the receiver is not - we should add the DTS offset to the receiver, eg. +1h
        if timeZone.isDaylightSavingTime(for: date) && !timeZone.isDaylightSavingTime(for: self) {
            
            return self.addingTimeInterval(timeZone.daylightSavingTimeOffset(for: date))
        }
        
        //the opposite
        if !timeZone.isDaylightSavingTime(for: date) && timeZone.isDaylightSavingTime(for: self) {
            
            return self.addingTimeInterval(-timeZone.daylightSavingTimeOffset(for: self))
        }
        
        return self
    }
}
