// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherResult = try? JSONDecoder().decode(WeatherResult.self, from: jsonData)

import Foundation

// MARK: - WeatherResult
struct WeatherResult: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [List]?
    let city: City?
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double?
}

// MARK: - List
struct List: Codable {
    // swiftlint:disable:next identifier_name
    let dt: Int?
    let main: Main?
    let weather: [Weather]?
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        // swiftlint:disable:next identifier_name
        case dt, main, weather, rain
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

struct Rain: Codable {
    let amount: Double?

    enum CodingKeys: String, CodingKey {
        case amount = "3h"
    }
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: String?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
