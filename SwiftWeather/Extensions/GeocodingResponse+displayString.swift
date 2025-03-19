//
//  GeocodingResponse+displayString.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

extension GeocodingResponse {
    var displayString: String {
        return "\(self.name), \(self.country.countryCodeToName())"
    }
}
