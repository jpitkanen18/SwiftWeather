//
//  WeatherService.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import Combine
import Foundation
import CoreLocation

class WeatherService {
    private let apiKey: String
    private let geoBase: String
    private let weatherBase: String
    private let reverseGeocodingBase: String
    
    init() {
        guard let apiKey = Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String else {
            fatalError("Weather API key not found in Info.plist")
        }
        guard let geoBase = Bundle.main.infoDictionary?["GEOCODING_BASE_URL"] as? String else {
            fatalError("Weather API geocoding base not found in Info.plist")
        }
        guard let weatherBase = Bundle.main.infoDictionary?["WEATHER_BASE_URL"] as? String else {
            fatalError("Weather API base URL not found in Info.plist")
        }
        guard let reverseGeocodingBase = Bundle.main.infoDictionary?["REVERSEGEOCODING_BASE_URL"] as? String else {
            fatalError("Weather API reverse geocoding base not found in Info.plist")
        }
        self.apiKey = apiKey
        self.geoBase = geoBase
        self.weatherBase = weatherBase
        self.reverseGeocodingBase = reverseGeocodingBase
    }
    
    private func call<T: Decodable>(
        endpoint: URL,
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, Error> {
        URLSession.shared
            .dataTaskPublisher(for: endpoint)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func reverseGeocode(for location: CLLocationCoordinate2D) -> AnyPublisher<[GeocodingResponse], Error> {
        self.call(endpoint: location.buildLocationUrl(
            base: reverseGeocodingBase,
            apiKey: apiKey)
        )
    }
    
    func geocode(for locationString: String) -> AnyPublisher<[GeocodingResponse], Error> {
        self.call(
            endpoint: locationString.buildGeocodingURL(
                geocodingBase: geoBase,
                location: locationString,
                apiKey: apiKey
            )
        )
    }
    
    func getWeather(for location: CLLocationCoordinate2D) -> AnyPublisher<WeatherResult, Error> {
        self.call(
            endpoint: location.buildLocationUrl(
                base: weatherBase,
                apiKey: apiKey)
        )
    }
}
