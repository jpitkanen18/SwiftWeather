//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//
import SwiftUI

struct CurrentWeather: View {
    @EnvironmentObject var weatherAPI: WeatherAPI
    @Binding var isCelsius: Bool
    var body: some View {
        ScrollView{
            VStack(alignment: .center) {
                if(weatherAPI.weather != nil && weatherAPI.weather?.list!.first != nil){
                    Text((weatherAPI.weather?.list!.first?.main?.temp!.covertFromKelvin(isCelsius: isCelsius).toSignedString()) ?? "+32")
                        .fontWeight(.bold)
                        .font(Font.system(size: 50))
                        .foregroundStyle(.white)
                    Text(weatherAPI.weather?.city?.name ?? "Helsinki")
                        .fontWeight(.bold)
                        .font(Font.system(size: 30))
                        .foregroundStyle(.white)
                    Text(weatherAPI.weather?.list!.first?.weather?.first?.description?.capitalized ?? "Sunny and hot")
                        .fontWeight(.light)
                        .font(Font.system(size: 16))
                        .foregroundStyle(.white)
                    HStack {
                        WeatherIconText(icon: .warm, value: (weatherAPI.weather?.list!.first?.main?.tempMax!.covertFromKelvin(isCelsius: isCelsius)) ?? 32)
                        WeatherIconText(icon: .cold, value: (weatherAPI.weather?.list!.first?.main?.tempMin!.covertFromKelvin(isCelsius: isCelsius)) ?? 32).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        WeatherIconText(icon: .rain, value: 22) // Constant due to a lack of data
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 30, trailing: 0))
                    Upcoming(isCelsius: $isCelsius)
                }
            }
        }
    }
}


#Preview {
    ZStack{
        BackgroundGradient().ignoresSafeArea()
        CurrentWeather(isCelsius: .constant(false))
            .environmentObject(WeatherAPI())
    }
}
