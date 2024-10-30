//
//  ContentView.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//

import SwiftUI
import Combine

struct MainScreen: View {
    @State var isCelsius = true
    @State var searchString = ""
    @State var inSearchMode = false
    @State var searchWeather = false
    @StateObject var weatherAPI = WeatherAPI()
    @StateObject private var locationManager = LocationManager()
    @State var locationInit = false
    @State var weatherInit = false
    
    var body: some View {
        ZStack {
            BackgroundGradient().ignoresSafeArea()
            VStack() {
                Header(isCelsius: $isCelsius)
                    .onAppear(perform: {
                        locationManager.checkLocationAuthorization()
                    })
                    .onReceive(locationManager.lastKnownLocation.publisher, perform: { location in
                        if(!locationInit) {
                            locationInit = true
                            Task {
                                try await self.weatherAPI.fetchReverseGeocoding(lat: location.latitude, lon: location.longitude)
                            }
                        }
                    })
                SearchBar(searchWeather: $searchWeather, searchString: $searchString, inSearchMode: $inSearchMode)
                if((weatherAPI.isSearching && inSearchMode) || weatherAPI.isLoading) {
                    ProgressView()
                        .tint(.white)
                } else if((!searchString.isEmpty || inSearchMode) && !searchWeather) {
                    SearchResults(searchInput: $searchString, searchWeather: $searchWeather, geocodingResults: weatherAPI.geocoding)
                } else {
                    WeatherInfo(isCelsius: $isCelsius)
                        .onReceive(weatherAPI.reverseGeocoding.publisher, perform: {
                            revGeocoding in
                            if(!weatherInit){
                                weatherInit = true
                                Task {
                                    do {
                                        try await self.weatherAPI.fetchWeather(lat: revGeocoding[0].lat, lon: revGeocoding[0].lon, home: true)
                                    } catch {
                                        print(error)
                                    }
                                }
                            }
                           
                        })
                }
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.snappy, value: isCelsius)
            .animation(.easeInOut, value: inSearchMode)
            .animation(.bouncy, value: weatherAPI.isLoading)
            .animation(.bouncy, value: weatherAPI.isSearching)
        }
        .environmentObject(weatherAPI)

    }
}

#Preview {
    MainScreen()
        .environmentObject(WeatherAPI())
}
