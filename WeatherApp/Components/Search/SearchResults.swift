//
//  SearchResults.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//
import SwiftUI

struct SearchResults: View {
    @Binding var searchInput: String
    @Binding var searchWeather: Bool
    var geocodingResults: GeocodingResults?
    @EnvironmentObject var weatherAPI: WeatherAPI
   
    var body: some View {
        ScrollView {
            VStack(alignment: .trailing) {
                if(geocodingResults != nil && !geocodingResults!.isEmpty){
                    ForEach(0..<geocodingResults!.count, id: \.self) { index in
                        SearchItem(searchInput: $searchInput, geocodingItem: geocodingResults![index])
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                                Task {
                                    searchWeather = true
                                    try await weatherAPI.fetchWeather(lat: geocodingResults![index].lat, lon: geocodingResults![index].lon)
                                }
                            }
                    }
                } else if (geocodingResults == nil || geocodingResults!.isEmpty){
                    Text("No results").font(Font.system(size: 30))
                        .foregroundStyle(.white)
                }
            }
            .animation(.bouncy, value: (geocodingResults ?? []).count)
        }
    }
}

#Preview {
    ZStack {
        BackgroundGradient().ignoresSafeArea()
        SearchResults(searchInput: .constant("Tu"), searchWeather: .constant(false), geocodingResults: [ Geocoding(name: "Turku", localNames: nil, lat: 24, lon: 25, country: "Finland", state: nil),  Geocoding(name: "Turku", localNames: nil, lat: 24, lon: 25, country: "Finland", state: nil),  Geocoding(name: "Turku", localNames: nil, lat: 24, lon: 25, country: "Finland", state: nil),  Geocoding(name: "Turku", localNames: nil, lat: 24, lon: 25, country: "Finland", state: nil)])
    }
   
}
