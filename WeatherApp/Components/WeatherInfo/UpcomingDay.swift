//
//  UpcomingDay.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//

import SwiftUI

struct UpcomingDay: View {
    
    var list: List?
    @Binding var isCelsius: Bool
    @Binding var isOpen: Int?
    var index: Int
    var bluecolor = Color(#colorLiteral(red: 0.31, green: 0.416, blue: 0.58, alpha: 1)) // #4f6a94
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                .fill(.clear)
                .stroke(bluecolor)
                .frame(height: isOpen == index ? 56*3 : 56)
            HStack {
                Text(NSDate(timeIntervalSince1970:(list?.dt!.doubleValue)!).toDayAndDateString())
                    .foregroundStyle(.white)
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 40))
                Spacer()
                VStack {
                    WeatherIconText(icon: .sun, value: (list?.main?.temp)!.covertFromKelvin(isCelsius: isCelsius))
                    if(index == isOpen) {
                        WeatherIconText(icon: .sun, value: (list?.main?.temp)!.covertFromKelvin(isCelsius: isCelsius))
                        WeatherIconText(icon: .sun, value: (list?.main?.temp)!.covertFromKelvin(isCelsius: isCelsius))
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 80))
            }
            
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
        UpcomingDay(list: List(dt: 1415637900, main: Main(temp: 69, tempMin: 420, tempMax: 6969), weather: nil), isCelsius: .constant(true), isOpen: .constant(nil), index: 0).environmentObject(WeatherAPI())
    }
}
