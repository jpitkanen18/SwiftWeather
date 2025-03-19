//
//  Geocoding.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//

import Foundation

struct GeocodingResponse: Codable {
    let name: String
    let localNames: LocalNames?
    let lat, lon: Double
    let country: String
    let state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

// MARK: - LocalNames
// swiftlint:disable identifier_name
struct LocalNames: Codable {
    let ar, ka, fr, hy: String?
    let uk, sr, de, ru: String?
    let be: String?
    let en: String?
    let zh, hu, mk, bg: String?
    let cs, la, th: String?
}
// swiftlint:enable identifier_name

typealias GeocodingResults = [GeocodingResponse]
