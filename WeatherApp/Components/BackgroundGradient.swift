//
//  BackgroundGradient.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//


import SwiftUI

struct BackgroundGradient: View {


    static let color0 = Color(red: 3/255, green: 39/255, blue: 92/255);

    static let color1 = Color(red: 148/255, green: 71/255, blue: 0/255, opacity: 0.67);


    let gradient = Gradient(colors: [color0, color1]);

    var body: some View {
        Rectangle()
        .fill(LinearGradient(
            gradient: gradient,
            startPoint: .init(x: 0.73, y: 0.94),
            endPoint: .init(x: 0.27, y: 0.06)
        ))
        .edgesIgnoringSafeArea(.all)

    }

}

#Preview {
    BackgroundGradient()
}

