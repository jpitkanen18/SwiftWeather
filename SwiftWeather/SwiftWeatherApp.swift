//
//  SwiftWeatherApp.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import SwiftUI

@main
struct SwiftWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .gradientBackground()
        }
        .environmentObject(appModel)
        .environmentObject(locationManager)
        
    }
    
    @StateObject private var appModel = AppModel()
    @StateObject private var locationManager = LocationManager()
}
