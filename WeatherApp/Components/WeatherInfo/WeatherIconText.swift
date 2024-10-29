//
//  WeatherIconText.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//

import SwiftUI

enum WeatherIcon: String {
    case cold = "ColdTemp"
    case warm = "WarmTemp"
    case sun = "sunIcon"
    case rain = "RainIcon"
}

struct WeatherIconText: View {
    
    var icon: WeatherIcon
    var value: Double
    
    var body: some View {
        HStack{
            Image(icon.rawValue)
            Text(getText())
                .foregroundStyle(.white)
        }
    }
    
    func getText() -> String {
        switch(icon) {
            case .cold:
                return "Min \(value.toSignedString())"
            case .warm:
                return "Max \(value.toSignedString())"
            case .sun:
                return value.toSignedString()
            case .rain:
                return "Rain \(value)mm"
        }
    }
}


#Preview {
    ZStack {
        BackgroundGradient().ignoresSafeArea()
        WeatherIconText(icon: .rain, value: -5)
    }
}
