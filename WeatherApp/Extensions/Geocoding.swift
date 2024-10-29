//
//  Geocoding.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//

extension Geocoding {
    func buildDisplayString() -> String {
        return "\(self.name), \(self.country.countryCodeToName())"
    }
}
