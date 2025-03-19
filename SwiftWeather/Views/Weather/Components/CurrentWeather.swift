//
//  CurrentWeather.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import SwiftUI

struct CurrentWeather: View {

    @EnvironmentObject private var weatherModel: WeatherModel
    @EnvironmentObject private var appModel: AppModel

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                if weatherModel.weatherResult != nil && weatherModel.weatherResult?.list!.first != nil {
                    Text((weatherModel.weatherResult?.list!.first?.main?.temp!.covertFromKelvin(
                            isCelsius: appModel.units == .celsius)
                            .toSignedString()) ?? "+32")
                        .fontWeight(.bold)
                        .font(Font.system(size: 50))
                        .foregroundStyle(.white)
                    Text(weatherModel.weatherResult?.city?.name ?? "Helsinki")
                        .fontWeight(.bold)
                        .font(Font.system(size: 30))
                        .foregroundStyle(.white)
                    Text(weatherModel.weatherResult?.list!.first?.weather?.first?.description?.capitalized
                         ?? "Sunny and hot")
                        .fontWeight(.light)
                        .font(Font.system(size: 16))
                        .foregroundStyle(.white)
                    HStack {
                        WeatherIconText(
                            icon: .warm,
                            value: (weatherModel.weatherResult?.list!.first?.main?.tempMax!.covertFromKelvin(
                                isCelsius: appModel.units == .celsius
                            )) ?? 32)
                        WeatherIconText(
                            icon: .cold,
                            value: (
                                weatherModel.weatherResult?.list!.first?.main?.tempMin!
                                    .covertFromKelvin(isCelsius: appModel.units == .celsius)
                            ) ?? 32
                        )
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: 10,
                                bottom: 0,
                                trailing: 10
                            )
                        )
                        WeatherIconText(
                            icon: .rain,
                            value: weatherModel.weatherResult?.list!.first?.rain?.amount ?? 22.0
                        )
                    }
                    .animation(.bouncy, value: appModel.units)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 30, trailing: 0))
                    Upcoming()
                }
            }
        }
    }
}

#Preview {
    ZStack {
        BackgroundGradient().ignoresSafeArea()
        CurrentWeather()
            .environmentObject(AppModel())
            .environmentObject(WeatherModel())
    }
}
