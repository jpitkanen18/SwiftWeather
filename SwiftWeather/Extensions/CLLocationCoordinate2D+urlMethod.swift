//
//  CLLocationCoordinate2D+urlMethod.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//
import CoreLocation

extension CLLocationCoordinate2D {
    func buildLocationUrl(
        base: String,
        apiKey: String) -> URL {
            let urlBase = "\(base)lat=\(self.latitude)&lon=\(self.longitude)"
            return urlBase.buildURL(apiKey: apiKey)
    }
}
