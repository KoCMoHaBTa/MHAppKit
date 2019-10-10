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
            
            static let queue = DispatchQueue(label: MHAppKit.bundleIdentifier + ".Date.init?(from:format:locale:timeZone:calendar:).Static.queue")
            static var map: [Configuration: DateFormatter] = [:]
        }
        
        let configuration = Configuration(format: format, locale: locale, timeZone: timeZone, calendar: calendar)
        var formatter: DateFormatter!
        
        Static.queue.sync {
            
            formatter = configuration.formatter(&Static.map)
        }
        
        guard let date = formatter.date(from: string) else { return nil }
        self = date
    }
    
    ///Creates an isntance of the receiver from a given string and date formatter
    public init?(from string: String, using formatter: DateFormatter) {
        
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
            
            static let queue = DispatchQueue(label: MHAppKit.bundleIdentifier + ".String.init(formatting:format:locale:timeZone:calendar:).Static.queue")
            static var map: [Configuration: DateFormatter] = [:]
        }
        
        let configuration = Configuration(format: format, locale: locale, timeZone: timeZone, calendar: calendar)
        var formatter: DateFormatter!
        
        Static.queue.sync {
            
            formatter = configuration.formatter(&Static.map)
        }
        
        let string = formatter.string(from: date)
        self = string
    }
    
    ///Creates an instance of the receiver by formatting a date using a given formatter.
    public init(formatting date: Date, using formatter: DateFormatter) {
        
        let string = formatter.string(from: date)
        self = string
    }
}

extension Locale {
    
    //- returns: An instance of a locale, that should be used when formatting dates that are transferred over the internet
    ///- note: This is a computed property.
    ///- note: The value is an instance of the `en_US_POSIX` locale
    public static var fixed: Locale {
        
        return Locale(identifier: "en_US_POSIX")
    }
}

extension TimeZone {
    
    ///An instance of a timezone, that should be used when formatting dates that are transferred over the internet.
    ///- note: This is a computed property.
    ///- note: The value is an instance of the UTC timezone
    public static var fixed: TimeZone {
        
        return .UTC
    }
    
    ///An instance of the UTC timezone.
    ///- note: This is a computed property.
    public static var UTC: TimeZone {
        
        return TimeZone(identifier: "UTC")!
    }
    
    ///An instance of the GMT timezone.
    ///- note: This is a computed property.
    public static var GMT: TimeZone {
        
        return TimeZone(identifier: "GMT")!
    }
}

extension Calendar {
    
    ///An instance of a calendar, that should be used when formatting dates that are transferred over the internet
    ///- note: This is a computed property.
    ///- note: The value is an instance of the Gregorian calendar, configured with `fixed` locale and timezone
    public static var fixed: Calendar {
        
        var calendar = Calendar.gregorian
        calendar.locale = .fixed
        calendar.timeZone = .fixed
        
        return calendar
    }
    
    
    ///An instance of the Gregorian calendar.
    ///- note: This is a computed property.
    public static var gregorian: Calendar {
        
        return Calendar(identifier: .gregorian)
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
