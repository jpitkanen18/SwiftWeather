//
//  String+helpers.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import Foundation
import CoreLocation
import UIKit

extension String {
    func buildURL(apiKey: String) -> URL {
        return URL(string: self + "&appid=\(apiKey)")!
    }

    func buildGeocodingURL(
        geocodingBase: String,
        location: String,
        apiKey: String) -> URL {
        let urlBase = "\(geocodingBase)\(location)"
        return urlBase.buildURL(apiKey: apiKey)
    }

    func highlightInput(input: String) -> String {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        let ranges = self.ranges(of: trimmed)
        if ranges.count == 0 || input.isEmpty {
            return self
        }
        let substring = self[..<ranges[0].lowerBound]
        let substring2 = self[ranges[0].upperBound...]
        return  "\(substring)**\(trimmed)**\(substring2)"
    }

    func countryCodeToName() -> String {
        let id: String = Locale.identifier(fromComponents: [
            NSLocale.Key.countryCode.rawValue: self
        ])
        guard let name = (Locale.current as NSLocale).displayName(forKey: .identifier, value: id) else { return self }
        return name
    }
}
