//
//  WeatherModel.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//
import SwiftUI
import Foundation
import Combine
import CoreLocation

class WeatherModel: ObservableObject {
    private let weatherService = WeatherService()
    private var cancellables = Set<AnyCancellable>()

    @Published var currentLocationString: String?
    @Published var isWeatherLoading: Bool = false
    @Published var isLocationLoading: Bool = false
    @Published var geocodingResults: [GeocodingResponse]?
    @Published var weatherResult: WeatherResult?
    @Published var searchString: String = "" {
        didSet {
            if !searchString.isEmpty {
                self.geocode(for: searchString)
            }
        }
    }
    @Published var selectedCity: GeocodingResponse? {
        didSet {
            if selectedCity == nil {
                self.weather(
                    for: locationManager?.wrappedValue.lastKnownLocation ?? CLLocationCoordinate2D(
                        latitude: 60.192059,
                        longitude: 24.945831
                    )
                )
            } else {
                self.weather(
                    for: CLLocationCoordinate2D(
                        latitude: selectedCity!.lat,
                        longitude: selectedCity!.lon
                    )
                )
            }
        }
    }

    private var locationSink: AnyCancellable? = nil
    
    private(set) var locationManager: EnvironmentObject<LocationManager>?
    
    func setLocationManager(_ locationManager: EnvironmentObject<LocationManager>) {
        self.locationManager = locationManager
        self.locationManager?.wrappedValue.startUpdatingLocation()
        
        locationSink = locationManager.wrappedValue.lastKnownLocation.publisher
            .sink(receiveValue: { newLocation in
                print("here")
            self.reverseGeocode(for: newLocation)
            self.weather(for: newLocation)
            self.locationSink = nil
        })
    }
    
    func geocode(for locationString: String) {
        weatherService.geocode(for: locationString)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) {
                var displayStrings: Set<String> = []
                self.geocodingResults = $0.filter {
                    if !displayStrings.contains($0.displayString) {
                        displayStrings.insert($0.displayString)
                        return true
                    } else {
                        return false
                    }
                }
            }
            .store(in: &cancellables)
    }

    func reverseGeocode(for location: CLLocationCoordinate2D) {
        self.isLocationLoading = true
        weatherService.reverseGeocode(for: location)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in  self.isLocationLoading = false }) { response in
                print(response)
                self.currentLocationString = response[0].displayString
            }
            .store(in: &cancellables)
    }

    func weather(for location: CLLocationCoordinate2D) {
        self.isWeatherLoading = true
        weatherService.getWeather(for: location)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in  self.isWeatherLoading = false }) { response in
                var dateStrings: Set<String> = []
                // Hack to get rid of dupes, blame me if you will
                let list = response.list!.filter { item in
                        let string = NSDate(timeIntervalSince1970: item.dt!.doubleValue).toDayAndDateString()
                        if dateStrings.contains(string) {
                            return false
                        } else {
                            dateStrings.insert(string)
                            return true
                        }
                }
                self.weatherResult = WeatherResult(
                    cod: response.cod,
                    message: response.message,
                    cnt: response.cnt,
                    list: list,
                    city: response.city
                )
                
            }
            .store(in: &cancellables)
    }
}
