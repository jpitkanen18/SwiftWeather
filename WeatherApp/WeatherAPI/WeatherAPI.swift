//
//  API.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//

import Foundation

public class WeatherAPI: ObservableObject {
    
    private let apiKey: String
    private let geocodingBase: String
    private let reverseGeocodingBase: String
    private let weatherBase: String
    
    // This is a failsafe, SwiftUI doesn't let environment objects throw an init error
    public var initFail = false
    
    @Published var geocoding: GeocodingResults? = nil
    @Published var reverseGeocoding: GeocodingResults? = nil
    @Published var weather: WeatherResult? = nil
    private var homeWeather: WeatherResult? = nil
    @Published var isSearching = false
    @Published var isLoading = false
    @Published var isHeaderLoading = false
    
    init() {
        if let key = Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String {
            self.apiKey = key
        } else {
            self.apiKey = ""
            self.initFail = true
        }
        if let geoBase = Bundle.main.infoDictionary?["GEOCODING_BASE_URL"] as? String {
            self.geocodingBase = geoBase
        } else {
            self.geocodingBase = ""
            self.initFail = true
        }
        if let weatherBase = Bundle.main.infoDictionary?["WEATHER_BASE_URL"] as? String {
            self.weatherBase = weatherBase
        } else {
            self.weatherBase = ""
            self.initFail = true
        }
        if let reverseGeocodingBase = Bundle.main.infoDictionary?["REVERSEGEOCODING_BASE_URL"] as? String {
            self.reverseGeocodingBase = reverseGeocodingBase
        } else {
            self.reverseGeocodingBase = ""
            self.initFail = true
        }
        print(self.apiKey)
        print(self.geocodingBase)
        print(self.weatherBase)
        print(self.reverseGeocodingBase)
    }
    
    private func buildGeocodingURL(location: String) -> URL {
        let urlBase = "\(geocodingBase)\(location)"
        return urlBase.buildURL(apiKey: self.apiKey)
    }
    
    private func buildReverseGeocodingUrl(lat: CGFloat, lon: CGFloat) -> URL {
        let urlBase = "\(reverseGeocodingBase)lat=\(lat)&lon=\(lon)"
        return urlBase.buildURL(apiKey: self.apiKey)
    }
    
    private func buildWeatherUrl(lat: CGFloat, lon: CGFloat) -> URL {
        let urlBase = "\(weatherBase)lat=\(lat)&lon=\(lon)"
        return urlBase.buildURL(apiKey: self.apiKey)
    }
    
   
    func fetchLocations(searchString: String) async throws -> Void {
        DispatchQueue.main.async {
            self.isSearching = true
        }
        if(searchString.isEmpty){
            DispatchQueue.main.async {
                self.isSearching = false
            }
            return
        }
        
        let url = buildGeocodingURL(location: searchString)

        let (data, _) = try await URLSession.shared.data(from: url)
        
        try Task.checkCancellation()

        let decoded = try JSONDecoder().decode(GeocodingResults.self, from: data)

        DispatchQueue.main.async {
            self.geocoding = decoded
            self.isSearching = false
        }
        
    }
    
    func fetchReverseGeocoding(lat: Double, lon: Double) async throws -> Void {
        DispatchQueue.main.async {
            self.isHeaderLoading = true
        }
        
        let url = buildReverseGeocodingUrl(lat: lat, lon: lon)

        let (data, _) = try await URLSession.shared.data(from: url)
        
        try Task.checkCancellation()

        let decoded = try JSONDecoder().decode(GeocodingResults.self, from: data)

        DispatchQueue.main.async {
            self.reverseGeocoding = decoded
            self.isHeaderLoading = false
        }
        
    }
    
    func fetchWeather(lat: Double, lon: Double, home: Bool = false) async throws -> Void {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        let url = buildWeatherUrl(lat: lat, lon: lon)

        let (data, _) = try await URLSession.shared.data(from: url)
        
        try Task.checkCancellation()
        let decoded = try JSONDecoder().decode(WeatherResult.self, from: data)
        if(home) {
            self.homeWeather = decoded
        }
        DispatchQueue.main.async {
            self.weather = decoded
            self.isLoading = false
        }
    }
    
    func revertToHome() {
        self.weather = self.homeWeather
    }
}
