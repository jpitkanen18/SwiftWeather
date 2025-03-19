//
//  WeatherView.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject private var appModel: AppModel
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var weatherModel: WeatherModel = .init()
    
    var body: some View {
        VStack {
            Header()
            .onAppear(perform: {
                if weatherModel.locationManager == nil {
                    weatherModel.setLocationManager(_locationManager)
                }
            })
            SearchBar()
            if weatherModel.isWeatherLoading {
                ProgressView()
                    .tint(.white)
            } else if !weatherModel.searchString.isEmpty {
                SearchResults()
            } else {
                WeatherInfo()
            }
        }
        .environmentObject(weatherModel)
        .frame(maxHeight: .infinity, alignment: .top)
        .animation(.easeInOut, value: appModel.state)
        .animation(.bouncy, value: weatherModel.isWeatherLoading)
        .animation(.bouncy, value: weatherModel.searchString.isEmpty)
    }
}
