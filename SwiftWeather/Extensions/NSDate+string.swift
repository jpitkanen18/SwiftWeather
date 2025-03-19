//
//  NSDate+string.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import Foundation

extension NSDate {
    func toDayAndDateString() -> String {
        let date = self as Date
        let weekday = date.formatted(.dateTime.weekday(.wide))
        let day = date.formatted(.dateTime.day(.defaultDigits))
        let month = date.formatted(.dateTime.month(.defaultDigits))
        return "\(weekday) \(day).\(month)"
    }
}
