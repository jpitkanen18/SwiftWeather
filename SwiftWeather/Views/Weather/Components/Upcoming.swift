//
//  Upcoming.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//
import SwiftUI

struct Upcoming: View {
    @EnvironmentObject var weatherModel: WeatherModel
    @State var isOpen: Int? = nil
    var body: some View {
            VStack(alignment: .leading) {
                Text("Upcoming days")
                    .font(Font.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                if(weatherModel.weatherResult != nil && !(weatherModel.weatherResult?.list!.isEmpty)!){
                    ForEach(1..<weatherModel.weatherResult!.list!.count, id: \.self) { index in
                        UpcomingDay(
                            list: weatherModel.weatherResult!.list![index],
                            isOpen: $isOpen,
                            index: index
                        )
                    }
                }
            }
            .padding()
    }
}

#Preview {
    ZStack{
        BackgroundGradient().ignoresSafeArea()
        Upcoming().environmentObject(WeatherModel())
    }
}
