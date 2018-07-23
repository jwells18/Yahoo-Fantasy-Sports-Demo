//
//  DateManager.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

class DateManager: NSObject{
    func createDate(string: String) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: string)
        return date!
    }
}

extension Double{
    func dateValue() -> Date {
        let timeInterval: TimeInterval = self
        let date = Date.init(timeIntervalSince1970: timeInterval/1000)
        
        return date
    }
}

extension Date {
    func dayAndTime() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E h:mma"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
    }
    
    func monthDayAndYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
    
    func startOfDay() -> Date {
        return NSCalendar.current.startOfDay(for: self)
    }
    
    func endOfDay() -> Date {
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        return NSCalendar.current.date(byAdding: components as DateComponents, to: self.startOfDay())!
    }
    
    func timestamp() -> Double{
        let timestamp = self.timeIntervalSince1970*1000
        return Double(timestamp)
    }
}
