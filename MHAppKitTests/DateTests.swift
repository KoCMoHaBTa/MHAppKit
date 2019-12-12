//
//  DateTests.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/24/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

#if !os(watchOS)
import Foundation
import XCTest
@testable import MHAppKit

class DateTests : XCTestCase {
    
    func testDateParsing() {
        
        guard let date = Date(from: "22.11.1987", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed) else {
            
            XCTFail("Uanble to parse the date")
            return
        }
        
        let string = String(formatting: date, format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        XCTAssertEqual(string, "22.11.1987")
        
        let components = date.components(in: .fixed)
        XCTAssertEqual(components.day, 22)
        XCTAssertEqual(components.month, 11)
        XCTAssertEqual(components.year, 1987)
    }
    
    func testDateFormatting() {
        
        var initialComponents = DateComponents()
        initialComponents.day = 11
        initialComponents.month = 1
        initialComponents.year = 1789
        
        guard let date = Date(from: initialComponents, in: .fixed) else {
            
            XCTFail("Uanble to create the date")
            return
        }
        
        let string = String(formatting: date, format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        XCTAssertEqual(string, "11.01.1789")
        
        guard let postDate = Date(from: string, format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed) else {
            
            XCTFail("Uanble to parse the date")
            return
        }
        
        let postComponents = postDate.components(in: .fixed)
        XCTAssertEqual(postComponents.day, 11)
        XCTAssertEqual(postComponents.month, 1)
        XCTAssertEqual(postComponents.year, 1789)
    }
    
    func testYearsPeriodCalcualtion() {
        
        guard
            let source = Date(from: "22.01.1987 12:23:34", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed),
            let destination = Date(from: "11.11.1989 01:30:00", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed) else {
                
                XCTFail("Uanble to parse the date")
                return
        }
        
        XCTAssertEqual(source.years(to: destination, in: .fixed), 2)
        XCTAssertEqual(destination.years(from: source, in: .fixed), 2)
    }
    
    func testMonthsPeriodCalcualtion() {
        
        guard
            let source = Date(from: "22.01.1987 12:23:34", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed),
            let destination = Date(from: "11.11.1989 01:30:00", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed) else {
                
                XCTFail("Uanble to parse the date")
                return
        }
        
        XCTAssertEqual(source.months(to: destination, in: .fixed), 33)
        XCTAssertEqual(destination.months(from: source, in: .fixed), 33)
    }
    
    func testDaysPeriodCalcualtion() {
        
        guard
            let source = Date(from: "11.01.1987 12:23:34", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed),
            let destination = Date(from: "22.01.1987 01:30:00", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed) else {
                
                XCTFail("Uanble to parse the date")
                return
        }
        
        XCTAssertEqual(source.days(to: destination, in: .fixed), 11)
        XCTAssertEqual(destination.days(from: source, in: .fixed), 11)
    }
    
    func testHoursPeriodCalcualtion() {
        
        guard
            let source = Date(from: "11.01.1987 01:23:34", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed),
            let destination = Date(from: "11.01.1987 05:30:00", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed) else {
                
                XCTFail("Uanble to parse the date")
                return
        }
        
        XCTAssertEqual(source.hours(to: destination, in: .fixed), 4)
        XCTAssertEqual(destination.hours(from: source, in: .fixed), 4)
    }
    
    func testMinutesPeriodCalcualtion() {
        
        guard
            let source = Date(from: "11.01.1987 01:23:34", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed),
            let destination = Date(from: "11.01.1987 01:30:00", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed) else {
                
                XCTFail("Uanble to parse the date")
                return
        }
        
        XCTAssertEqual(source.minutes(to: destination, in: .fixed), 6)
        XCTAssertEqual(destination.minutes(from: source, in: .fixed), 6)
    }
    
    func testSecondsPeriodCalcualtion() {
        
        guard
            let source = Date(from: "11.01.1987 01:23:04", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed),
            let destination = Date(from: "11.01.1987 01:23:54", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed) else {
                
                XCTFail("Uanble to parse the date")
                return
        }
        
        XCTAssertEqual(source.seconds(to: destination, in: .fixed), 50)
        XCTAssertEqual(destination.seconds(from: source, in: .fixed), 50)
    }
    
    func testDaysInMonth() {
        
        let d1 = Date(from: "11.01.2011", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        let d2 = Date(from: "11.02.2011", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        let d3 = Date(from: "01.02.2012", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        
        XCTAssertEqual(d1?.daysInMonth(in: .fixed), 31)
        XCTAssertEqual(d2?.daysInMonth(in: .fixed), 28)
        XCTAssertEqual(d3?.daysInMonth(in: .fixed), 29)
    }
    
    func testDaysInYear() {
        
        let d1 = Date(from: "11.02.2011", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        let d2 = Date(from: "01.02.2012", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        
        XCTAssertEqual(d1?.daysInYear(in: .fixed), 365)
        XCTAssertEqual(d2?.daysInYear(in: .fixed), 366)
    }
    
    func testMonthsInYear() {
        
        let d1 = Date(from: "11.02.2011", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        XCTAssertEqual(d1?.monthsInYear(in: .fixed), 12)
    }
    
    func testWekksInMonth() {
        
        let d1 = Date(from: "11.02.2011", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        XCTAssertEqual(d1?.weeksInMonth(in: .fixed), 5)
    }
    
    func testWeeksInYear() {
        
        let d1 = Date(from: "11.02.2011", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        XCTAssertEqual(d1?.weeksInYear(in: .fixed), 53)
    }
    
    func testFirstDateOfMonth() {
        
        let d1 = Date(from: "11.02.2011", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        let d2 = Date(from: "01.02.2012", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        
        XCTAssertEqual(d1?.firstDateOfMonth(in: .fixed)?.components(in: .fixed).day, 1)
        XCTAssertEqual(d2?.firstDateOfMonth(in: .fixed)?.components(in: .fixed).day, 1)
    }
    
    func testLastDateOfMonth() {
        
        let d1 = Date(from: "11.02.2011", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        let d2 = Date(from: "01.02.2012", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        
        XCTAssertEqual(d1?.lastDateOfMonth(in: .fixed)?.components(in: .fixed).day, 28)
        XCTAssertEqual(d2?.lastDateOfMonth(in: .fixed)?.components(in: .fixed).day, 29)
    }
    
    func testAddingComponents() {
        
        let source = Date(from: "22.01.1987 12:23:34", format: "dd.MM.yyyy hh:mm:ss", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        
        var components = DateComponents()
        components.year = 2
        components.month = 2
        components.day = 5
        components.hour = 3
        components.minute = 15
        components.second = 10
        
        let destination = source?.adding(components, in: .fixed)
        
        let dc = destination?.components(in: .fixed)
        XCTAssertEqual(dc?.year, 1989)
        XCTAssertEqual(dc?.month, 3)
        XCTAssertEqual(dc?.day, 27)
        XCTAssertEqual(dc?.hour, 3)
        XCTAssertEqual(dc?.minute, 38)
        XCTAssertEqual(dc?.second, 44)
    }
    
    func testLastDateOfYear() {
        
        let date = Date(from: "11.02.2011", format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)!
        let lastDateOfYear = date.lastDateOfYear(in: .fixed)!
        
        let lastDateOfYearComponents = lastDateOfYear.components(in: .fixed)
        XCTAssertEqual(lastDateOfYearComponents.day, 31)
        XCTAssertEqual(lastDateOfYearComponents.month, 12)
        XCTAssertEqual(lastDateOfYearComponents.year, 2011)
        
        let lastDateOfYearString = String(formatting: lastDateOfYear, format: "dd.MM.yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        XCTAssertEqual(lastDateOfYearString, "31.12.2011")
    }
    
    func testDayAndShortMonth() {
        
        let lastYearDateString = "31 Dec"
        let shortMonthDate =  String(formatting: Date().lastDateOfYear(in: .fixed)!, format: "dd MMM", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        XCTAssertEqual(shortMonthDate, lastYearDateString)
    }
    
    func testShortMonthString()
    {
        let lastYearDateString = "Dec"
        let shortMonthDate = String(formatting: Date().lastDateOfYear(in: .fixed)!, format: "MMM", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        XCTAssertEqual(shortMonthDate, lastYearDateString)
    }
    
    func testDatePlusHours()
    {
        let minimumWaitingHours = 4
        let minimumRoundUpMins = 15
        let currentTimeString = "26/06/2015 3:14 pm"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy h:mm a"
        dateFormatter.timeZone = .fixed
        dateFormatter.locale = .fixed
        dateFormatter.calendar = .fixed
        
        let currentDate = dateFormatter.date(from: currentTimeString)!
        let returnedDate = currentDate.addingTimeInterval(TimeInterval(hours: minimumWaitingHours))
        
        //Compare date strings
        let currentDateString =  String(formatting: currentDate, format: "yyyy-MM-dd", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        let returnedDateString = String(formatting: returnedDate, format: "yyyy-MM-dd", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        XCTAssertEqual(currentDateString, returnedDateString)
        
        var returnedDateComp = returnedDate.components(in: .fixed)
        let currentDateComp = currentDate.components(in: .fixed)
        
        
        /* Compare calendar component hours */
        XCTAssertEqual(currentDateComp.hour! + minimumWaitingHours, returnedDateComp.hour, "Minimum waiting hours is not correct")
        
        /* Round up to nearest 15 mins */
        returnedDateComp.minute = Int((ceil(Float(returnedDateComp.minute!) / Float(minimumRoundUpMins))) * Float(minimumRoundUpMins))
        
        /* Compare minimum waiting minutes
         [Time] should be the current time + 4 hours,
         rounded to the next 15 minute interval. So at 12:01pm,
         [Time] = 4:15pm. At 12:16pm, [Time] = 4:30pm.
         At 3:14pm, [Time] = 7:15pm
         */
        XCTAssertEqual(returnedDateComp.minute, 15, "Minimum minutes is not correct");
    }
    
    func testDatePlusDays() {
        
        let date = Date(from: "2017-03-01", format: "yyyy-MM-dd", locale: .fixed, timeZone: .fixed, calendar: .fixed)!
        
        let d1 = date.adding(.day, value: 26, in: .fixed)!
        let s1 = String(formatting: d1, format: "yyyy-MM-dd", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        XCTAssertEqual(s1, "2017-03-27")
        
        var c2 = DateComponents()
        c2.day = 26
        let d2 = date.adding(c2, in: .fixed)!
        let s2 = String(formatting: d2, format: "yyyy-MM-dd", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        XCTAssertEqual(s2, "2017-03-27")
    }
    
    func testDateFromDDMMYYYYString()
    {
        let result = Date(from: "10/11/1911", format: "dd/MM/yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        
        // 10/11/1911
        let date = Date(timeIntervalSince1970: -1834876800)
        
        // verify
        XCTAssertEqual(result, date);
    }
    
    func testDdmmYYYYFormattedDateString()
    {
        // 10/11/1911
        let date = Date(timeIntervalSince1970: -1834876800)
        
        // execute
        let result = String(formatting: date, format: "dd/MM/yyyy", locale: .fixed, timeZone: .fixed, calendar: .fixed)
        
        // verify
        XCTAssertEqual(result, "10/11/1911")
    }
}
#endif
