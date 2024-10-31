//
//  NSDate.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//

import Foundation

extension NSDate {
    func toDayAndDateString() -> String {
        let date = self as Date
        return "\(date.formatted(.dateTime.weekday(.wide))) \(date.formatted(.dateTime.day(.defaultDigits))).\(date.formatted(.dateTime.month(.defaultDigits)))"
    }
}
