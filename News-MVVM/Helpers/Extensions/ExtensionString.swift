//
//  ExtensionString.swift
//  Zumra
//
//  Created by Mohamed Shaat on 4/7/18.
//  Copyright © 2018 10degree. All rights reserved.
//

import UIKit
import LocalizableLib
extension Int {
    func getCurrentDay () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:  MoLocalization.currentAppleLanguage())
        dateFormatter.dateFormat  = "EEEE"//"EE" to get short style
        let dayInWeek = dateFormatter.string(from:  NSDate(timeIntervalSince1970: TimeInterval(self)) as Date)
        return dayInWeek
    }
    func getCurrentMonth () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:  MoLocalization.currentAppleLanguage())
        dateFormatter.dateFormat  = "LLLL"//"EE" to get short style
        let month = dateFormatter.string(from:  NSDate(timeIntervalSince1970: TimeInterval(self)) as Date)
        return month
    }
    func getCurrentYear () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:  MoLocalization.currentAppleLanguage())
        dateFormatter.dateFormat  = "yyyy"//"EE" to get short style
        let year = dateFormatter.string(from:  NSDate(timeIntervalSince1970: TimeInterval(self)) as Date)
        return year
    }
    func getCurrentDateString () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:  MoLocalization.currentAppleLanguage())
        if MoLocalization.currentAppleLanguage() == "ar" {
            dateFormatter.dateFormat = "dd-MM-yyyy"
        }
        else {
            dateFormatter.dateFormat = "dd-MM-yyyy"
        }
        let dateString = dateFormatter.string(from:  NSDate(timeIntervalSince1970: TimeInterval(self)) as Date)
        return dateString
    }
    func getAge()->Int {
        let birthdayDate =  Date(timeIntervalSince1970: TimeInterval(self))
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
}
