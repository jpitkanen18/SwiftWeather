//
//  Toggle.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//

import SwiftUI

struct UnitToggle: View {
    
    @Binding var isCelsius: Bool
    
    var body: some View{
        ZStack(alignment: isCelsius ? .trailing : .leading) {
            Capsule()
                .fill(isCelsius ? Color.green : Color.gray)
                .frame(width: 65.0, height: 30.0)
                .animation(.easeInOut, value: isCelsius)
            HStack{
                Text("C°")
                    .opacity(isCelsius ? 1.0 : 0)
                    .animation(.easeInOut, value: isCelsius)
                Spacer()
                Text("F°")
                    .opacity(isCelsius ? 0 : 1.0)
                    .animation(.easeInOut, value: isCelsius)
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10.0))
            .frame(width: 65.0,height: 30.0)
            Circle().fill(Color.white)
                .frame(width: 28.0, height: 28.0)
                .padding(EdgeInsets(top: 0, leading: 1, bottom: 0, trailing: 3.0))
                .animation(.easeInOut, value: isCelsius)
        }
        .onTapGesture {
            isCelsius = !isCelsius
        }
       
    }
}



#Preview {
    UnitToggle(isCelsius: .constant(false))
}
