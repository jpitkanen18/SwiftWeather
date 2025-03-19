//
//  Header.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import SwiftUI

struct Header: View {
    @EnvironmentObject private var appModel: AppModel
    @EnvironmentObject private var weatherModel: WeatherModel

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Weather Site")
                        .font(Font.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    if weatherModel.currentLocationString != nil {
                        Text("Your current location:")
                            .font(Font.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                        Text(weatherModel.currentLocationString!)
                            .font(Font.system(size: 14))
                            .fontWeight(.light)
                            .foregroundStyle(.white)
                    } else if weatherModel.isLocationLoading {
                        ProgressView()
                            .tint(.white)
                    }

                }
                Spacer()
                UnitToggle()
            }
        }.padding()
    }
}

#Preview {
    Header()
        .environmentObject(AppModel())
        .environmentObject(WeatherModel())
}
