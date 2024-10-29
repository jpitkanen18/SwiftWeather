//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//
import SwiftUI

struct WeatherInfo: View {
    
    @Binding var isCelsius: Bool
    
    var body: some View {
        CurrentWeather(isCelsius: $isCelsius)
    }
}

#Preview {
    WeatherInfo(isCelsius: .constant(true))
}
