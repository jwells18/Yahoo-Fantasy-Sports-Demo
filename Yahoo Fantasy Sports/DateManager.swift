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
    func monthAndDay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: self).capitalized
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self).capitalized
    }
    
    func timeLong() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self).capitalized
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
