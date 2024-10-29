//
//  Header.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//

import SwiftUI

struct Header: View {
    
    @Binding var isCelsius: Bool
    @EnvironmentObject var weatherAPI: WeatherAPI
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text("Weather Site")
                        .font(Font.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    if(weatherAPI.reverseGeocoding != nil && !weatherAPI.reverseGeocoding!.isEmpty) {
                        Text("Your current location:")
                            .font(Font.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                        Text(weatherAPI.reverseGeocoding![0].buildDisplayString())
                            .font(Font.system(size: 14))
                            .fontWeight(.light)
                            .foregroundStyle(.white)
                    } else if (weatherAPI.isHeaderLoading) {
                        ProgressView()
                            .tint(.white)
                    }
                   
                }
                Spacer()
                UnitToggle(isCelsius: $isCelsius)
            }
        }.padding()
    }
}

#Preview {
    Header(isCelsius: .constant(true))
}
