//
//  Misc.swift
//  ShotsDemo
//
//  Created by Meng To on 2014-07-04.
//  Copyright (c) 2014 Meng To. All rights reserved.
//

import UIKit

func degreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(M_PI / 180)
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func imageFromURL(URL: String) -> UIImage {
    let url = NSURL(string: URL)
    let data = NSData(contentsOfURL: url!)
    return UIImage(data: data!)!
}

extension UIColor {
    convenience init(hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if hex.hasPrefix("#") {
            let index   = advance(hex.startIndex, 1)
            let hex     = hex.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (countElements(hex)) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                println("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

func rgbaToUIColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func stringFromDate(date: NSDate, format: String) -> String {
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.stringFromDate(date)
}

func dateFromString(date: String, format: String) -> NSDate {
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.dateFromString(date)!
}

func randomStringWithLength (len : Int) -> NSString {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    var randomString : NSMutableString = NSMutableString(capacity: len)
    
    for (var i=0; i < len; i++){
        var length = UInt32 (letters.length)
        var rand = arc4random_uniform(length)
        randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
    }
    
    return randomString
}

func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
    let calendar = NSCalendar.currentCalendar()
    let unitFlags = NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekOfYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitSecond
    let now = NSDate()
    let earliest = now.earlierDate(date)
    let latest = (earliest == now) ? date : now
    let components:NSDateComponents = calendar.components(unitFlags, fromDate: earliest, toDate: latest, options: nil)
    
    if (components.year >= 2) {
        return "\(components.year)y"
    } else if (components.year >= 1){
        if (numericDates){
            return "1y"
        } else {
            return "1y"
        }
    } else if (components.month >= 2) {
        return "\(components.month)"
    } else if (components.month >= 1){
        if (numericDates){
            return "1M"
        } else {
            return "1M"
        }
    } else if (components.weekOfYear >= 2) {
        return "\(components.weekOfYear)w"
    } else if (components.weekOfYear >= 1){
        if (numericDates){
            return "1w"
        } else {
            return "1w"
        }
    } else if (components.day >= 2) {
        return "\(components.day)d"
    } else if (components.day >= 1){
        if (numericDates){
            return "1d"
        } else {
            return "1d"
        }
    } else if (components.hour >= 2) {
        return "\(components.hour)h"
    } else if (components.hour >= 1){
        if (numericDates){
            return "1h"
        } else {
            return "1h"
        }
    } else if (components.minute >= 2) {
        return "\(components.minute)m"
    } else if (components.minute >= 1){
        if (numericDates){
            return "1m"
        } else {
            return "1m"
        }
    } else if (components.second >= 3) {
        return "\(components.second)s"
    } else {
        return "now"
    }
    
}