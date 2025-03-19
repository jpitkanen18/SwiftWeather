//
//  UpcomingDay.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//


import SwiftUI

struct UpcomingDay: View {
    
    var list: List?
    @Binding var isOpen: Int?
    var index: Int
    @EnvironmentObject private var appModel: AppModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                .fill(.clear)
                .stroke(Color.lightBlue)
                .frame(height: isOpen == index ? 56 * 3 : 56)
            HStack {
                Text(NSDate(timeIntervalSince1970:(list?.dt!.doubleValue)!).toDayAndDateString())
                    .foregroundStyle(.white)
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                Spacer()
                VStack(alignment: .leading) {
                    WeatherIconText(
                        icon: .sun,
                        value: (list?.main?.temp)!
                            .covertFromKelvin(
                                isCelsius: appModel.units == .celsius
                            )
                    )
                    if(index == isOpen) {
                        WeatherIconText(
                            icon: .warm,
                            value: (list?.main?.tempMax)!
                                .covertFromKelvin(
                                    isCelsius: appModel.units == .celsius
                                )
                        )
                        WeatherIconText(
                            icon: .cold,
                            value: (list?.main?.tempMin)!
                                .covertFromKelvin(
                                    isCelsius: appModel.units == .celsius
                                )
                        )
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 60))
                
            }
            .clipped()
            
        }
        .animation(.bouncy, value: isOpen)
        .contentShape(Rectangle())
        .onTapGesture {
            if(isOpen == index){
                isOpen = nil
            } else {
                isOpen = index
            }
        }
    }
}

#Preview {
    ZStack{
        BackgroundGradient().ignoresSafeArea()
        UpcomingDay(
            list: List(
                dt: 1415637900,
                main: Main(temp: 69, tempMin: 420, tempMax: 6969),
                weather: nil,
                rain: nil
            ),
            isOpen: .constant(nil),
            index: 0
        )
        .environmentObject(AppModel())
    }
}
