//
//  Upcoming.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//

import SwiftUI


struct Upcoming: View {
    @EnvironmentObject var weatherAPI: WeatherAPI
    @Binding var isCelsius: Bool
    @State var isOpen: Int? = nil
    var body: some View {
            VStack(alignment: .leading) {
                Text("Upcoming days")
                    .font(Font.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                if(weatherAPI.weather != nil && !(weatherAPI.weather?.list!.isEmpty)!){
                    ForEach(1..<weatherAPI.weather!.list!.count, id: \.self) { index in
                        UpcomingDay(list: weatherAPI.weather!.list![index], isCelsius: $isCelsius, isOpen: $isOpen, index: index)
                    }
                }
            }
            .padding()
    }
}

#Preview {
    ZStack{
        BackgroundGradient().ignoresSafeArea()
        Upcoming(isCelsius: .constant(true)).environmentObject(WeatherAPI())
    }
}
