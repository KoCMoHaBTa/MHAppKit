//
//  Date+Formatting.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/24/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

extension Date {
    
    ///Creates an isntance of the receiver from a given string, format, locale, timeZone and calendar.
    ///- note: For user visible dates - pass nil for locale, timeZone and calendar. For internet dates - pass fixed locale, timeZone and calendar values.
    public init?(from string: String, format: String, locale: Locale? = nil, timeZone: TimeZone? = nil, calendar: Calendar? = nil) {
        
        struct Static {
            
            static var map: [Configuration: DateFormatter] = [:]
        }
        
        let configuration = Configuration(format: format, locale: locale, timeZone: timeZone, calendar: calendar)
        let formatter = configuration.formatter(&Static.map)
        
        guard let date = formatter.date(from: string) else { return nil }
        self = date
    }
}

extension String {
    
    ///Formats a date for a given template in user visible representation
    public init?(formatting date: Date, template: String) {
        
        guard let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: nil) else { return nil }
        self.init(formatting: date, format: format, locale: nil, timeZone: nil, calendar: nil)
    }
    
    ///Formats a date for a given format, locale, timeZone and calendar.
    ///- note: For user visible dates - pass nil for locale, timeZone and calendar. For internet dates - pass fixed locale, timeZone and calendar values.
    public init(formatting date: Date, format: String, locale: Locale? = nil, timeZone: TimeZone? = nil, calendar: Calendar? = nil) {
        
        struct Static {
            
            static var map: [Configuration: DateFormatter] = [:]
        }
        
        let configuration = Configuration(format: format, locale: locale, timeZone: timeZone, calendar: calendar)
        let formatter = configuration.formatter(&Static.map)
        
        let string = formatter.string(from: date)
        self = string
    }
}

extension Locale {
    
    //this is computed property in order to avoid mutation
    public static var fixed: Locale {
        
        return Locale(identifier: "en_US_POSIX")
    }
}

extension TimeZone {
    
    //this is computed property in order to avoid mutation
    public static var fixed: TimeZone {
        
        return TimeZone(identifier: "UTC")!
    }
}

extension Calendar {
    
    //this is computed property in order to avoid mutation
    public static var fixed: Calendar {
        
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.locale = .fixed
        calendar.timeZone = .fixed
        
        return calendar
    }
}

extension DateFormatter {
    
    public static var fixed: DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .fixed
        dateFormatter.locale = .fixed
        dateFormatter.timeZone = .fixed
        
        return dateFormatter
    }
    
    public func with(format: String) -> DateFormatter {
        
        let dateFormatter = self
        dateFormatter.dateFormat = format
        
        return dateFormatter
    }
}

///Used as key for NSDateFormatter mapping dictionaries
private struct Configuration: Hashable {
    
    let format: String
    let locale: Locale?
    let timeZone: TimeZone?
    let calendar: Calendar?
    
    var hashValue: Int {
        
        return self.format.hashValue
            &+ (self.locale?.identifier.hashValue ?? 0)
            &+ (self.timeZone?.identifier.hashValue ?? 0)
            &+ (self.calendar?.identifier.hashValue ?? 0)
    }
    
    func buildFormatter() -> DateFormatter {
        
        let formatter = DateFormatter()
        formatter.dateFormat = self.format
        formatter.locale = self.locale
        formatter.timeZone = self.timeZone
        formatter.calendar = self.calendar
        
        return formatter
    }
    
    func formatter( _ map: inout [Configuration: DateFormatter]) -> DateFormatter {
        
        //try to get existing formatter
        if let formatter = map[self] {
            
            return formatter
        }
        
        //build one and register it into the map
        let formatter = self.buildFormatter()
        map[self] = formatter
        
        return formatter
    }
}

private func ==(lhs: Configuration, rhs: Configuration) -> Bool {
    
    return lhs.format == rhs.format
        && lhs.locale?.identifier == rhs.locale?.identifier
        && lhs.timeZone?.identifier == rhs.timeZone?.identifier
        && lhs.calendar?.identifier == rhs.calendar?.identifier
}
