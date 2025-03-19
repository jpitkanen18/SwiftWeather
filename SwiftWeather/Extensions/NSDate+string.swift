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
        return "\(date.formatted(.dateTime.weekday(.wide))) \(date.formatted(.dateTime.day(.defaultDigits))).\(date.formatted(.dateTime.month(.defaultDigits)))"
    }
}

