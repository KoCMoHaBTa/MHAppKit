//
//  Date+Components.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/24/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

extension Date {
    
    public init?(from components: DateComponents, in calendar: Calendar = .current) {
        
        guard let date = calendar.date(from: components) else { return nil }
        self = date
    }
}

extension Date {
    
    ///return the value of the specified component
    public func component(_ component: Calendar.Component, in calendar: Calendar = .current) -> Int {
        
        return calendar.component(component, from: self)
    }
    
    ///returns all the components of the receiver
    public func components(in calendar: Calendar = .current) -> DateComponents {
        
        return calendar.dateComponents(in: calendar.timeZone, from: self)
    }
    
    ///returns the specified components of the receiver
    public func components(_ components: Set<Calendar.Component>, in calendar: Calendar = .current) -> DateComponents {
        
        return calendar.dateComponents(components, from: self)
    }
    
    ///returns the specified components representing the difference between the reciever and the supplied date
    public func components(_ components: Set<Calendar.Component>, to date: Date, in calendar: Calendar = .current) -> DateComponents {
        
        return calendar.dateComponents(components, from: self, to: date)
    }
    
    func range(of smaller: Calendar.Component, in larger: Calendar.Component, in calendar: Calendar = .current) -> Range<Int>? {
        
        return calendar.range(of: smaller, in: larger, for: self)
    }
}

//The number of units, representing the difference from the receiver to a given date
extension Date {
    
    public func seconds(to date: Date, in calendar: Calendar = .current) -> Int? {
        
        return self.components([.second], to: date, in: calendar).second
    }
    
    public func minutes(to date: Date, in calendar: Calendar = .current) -> Int? {
        
        return self.components([.minute], to: date, in: calendar).minute
    }
    
    public func hours(to date: Date, in calendar: Calendar = .current) -> Int? {
        
        return self.components([.hour], to: date, in: calendar).hour
    }
    
    public func days(to date: Date, in calendar: Calendar = .current) -> Int? {
        
        return self.components([.day], to: date, in: calendar).day
    }
    
    public func months(to date: Date, in calendar: Calendar = .current) -> Int? {
        
        return self.components([.month], to: date, in: calendar).month
    }
    
    public func years(to date: Date, in calendar: Calendar = .current) -> Int? {
        
        return self.components([.year], to: date, in: calendar).year
    }
}

//The number of units, representing the difference from a given date to the receiver
extension Date {
    
    public func seconds(from date: Date, in calendar: Calendar = .current) -> Int? {
        
        return date.components([.second], to: self, in: calendar).second
    }
    
    public func minutes(from date: Date, in calendar: Calendar = .current) -> Int? {
        
        return date.components([.minute], to: self, in: calendar).minute
    }
    
    public func hours(from date: Date, in calendar: Calendar = .current) -> Int? {
        
        return date.components([.hour], to: self, in: calendar).hour
    }
    
    public func days(from date: Date, in calendar: Calendar = .current) -> Int? {
        
        return date.components([.day], to: self, in: calendar).day
    }
    
    public func months(from date: Date, in calendar: Calendar = .current) -> Int? {
        
        return date.components([.month], to: self, in: calendar).month
    }
    
    public func years(from date: Date, in calendar: Calendar = .current) -> Int? {
        
        return date.components([.year], to: self, in: calendar).year
    }
}

extension Date {
    
    public func daysInMonth(in calendar: Calendar = .current) -> Int? {
        
        return self.range(of: .day, in: .month, in: calendar)?.count
    }
    
    public func daysInYear(in calendar: Calendar = .current) -> Int? {
        
        var days = 0
        var components = self.components(in: calendar)
        
        let monthsInYear = self.monthsInYear(in: calendar) ?? 0
        for i in 1...monthsInYear  {
            
            components.month = i
            if let daysInMonth = Date(from: components, in: calendar)?.daysInMonth(in: calendar) {
                
                days += daysInMonth
            }
        }
        
        return days
    }
    
    public func monthsInYear(in calendar: Calendar = .current) -> Int? {
        
        return self.range(of: .month, in: .year, in: calendar)?.count
    }
    
    public func weeksInMonth(in calendar: Calendar = .current) -> Int? {
        
        return self.range(of: .weekOfMonth, in: .month, in: calendar)?.count
    }
    
    public func weeksInYear(in calendar: Calendar = .current) -> Int? {
        
        return self.range(of: .weekOfYear, in: .year, in: calendar)?.count
    }
}

extension Date {
    
    ///returns the weekday index of the receiver in given calendar.
    ///the implementation retrieves the weekday unit and substract 1 from it.
    ///the result is a value from 0 to N (where for the Gregorian calendar N=6 and 0 is Sunday).
    public func weekdayIndex(in calendar: Calendar = .current) -> Int {
        
        return self.component(.weekday, in: calendar) - 1
    }
    
    public func weekdayName(in calendar: Calendar = .current) -> String {
        
        let index = self.weekdayIndex(in: calendar)
        let name = calendar.weekdaySymbols[index]
        return name
    }
}

extension Date {
    
    ///returns a date representing the first day of the receiver's month
    public func firstDateOfMonth(in calendar: Calendar = .current) -> Date? {
        
        var components = self.components(in: calendar)
        components.day = 1
        
        let result = calendar.date(from: components)
        return result
    }
    
    ///returns a date representing the last day of the receiver's month
    public func lastDateOfMonth(in calendar: Calendar = .current) -> Date? {
        
        var components = self.components(in: calendar)
        components.month = (components.month ?? 0) + 1
        components.day = 0
        
        let result = calendar.date(from: components)
        return result
    }
    
    ///returns a date reprsenting the last day of the receiver's year
    func lastDateOfYear(in calendar: Calendar = .current) -> Date? {
        
        var components = self.components(in: calendar)
        components.day = 0 //setting the day to 0 will result in the last date of the previous month
        components.month = 1 //setting the month to the 1rs in the year and day=0 will result in the last date and month of the previous year
        
        //for some reason - incrementing year with 1 does not change it
        let lastDateOfPreviousyear = calendar.date(from: components)
        
        //so we need to add 1 year to the date in an alternative way
        var yearComponent = DateComponents()
        yearComponent.year = 1
        
        //the result should be the last date of the current year of the receiver, eg. 31 Dec 2016
        let result = lastDateOfPreviousyear?.adding(yearComponent, in: calendar)
        return result
    }
}

extension Date {
    
    ///returns a date by adding components to the receiver
    public func adding(_ components: DateComponents, in calender: Calendar = .current) -> Date? {
        
        return calender.date(byAdding: components, to: self)
    }
    
    ///adds the specified components to the receiver
    public mutating func add(_ components: DateComponents, in calender: Calendar = .current) {
        
        if let date = self.adding(components, in: calender) {
            
            self = date
        }
    }
    
    ///returns a date by adding a given component and value to the receiver
    public func adding(_ component: Calendar.Component, value: Int, in calendar: Calendar = .current) -> Date? {
        
        return calendar.date(byAdding: component, value: value, to: self)
    }
    
    ///adds the specified component and value to the receiver
    public mutating func add(_ component: Calendar.Component, value: Int, in calendar: Calendar = .current) {
        
        if let date = self.adding(component, value: value, in: calendar) {
            
            self = date
        }
    }
}
