//
//  NumberManager.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/23/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

extension NSNumber{
    func currencyString(maxFractionDigits: Int) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = maxFractionDigits
        let currencyString = formatter.string(from: self)
        
        return currencyString!
    }
    
    func shortNumberString(style: NumberFormatter.Style) -> String {
        let formatter = NumberFormatter()
        
        typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "K"),
                                           (1_000_000.0, 1_000_000.0, "M"),
                                           (1_000_000_000.0, 1_000_000_000.0, "B")]
        
        let startValue = abs(self.doubleValue)
        let abbreviation:Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        } ()
        
        let value = self.doubleValue / abbreviation.divisor
        formatter.positiveSuffix = abbreviation.suffix
        formatter.negativeSuffix = abbreviation.suffix
        formatter.allowsFloats = true
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.numberStyle = style
        
        return formatter.string(from: NSNumber(value: value))!
    }
    
    func dateValue() -> Date {
        let timeInterval: TimeInterval = self.doubleValue
        let date = Date.init(timeIntervalSince1970: timeInterval/1000)
        
        return date
    }
}
