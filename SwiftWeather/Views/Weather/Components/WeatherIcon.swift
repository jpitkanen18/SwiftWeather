//
//  WeatherIcon.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import SwiftUI

enum WeatherIcon: String, Decodable, Encodable {
    case cold = "ColdTemp"
    case warm = "WarmTemp"
    case sun = "sunIcon"
    case rain = "RainIcon"
}

struct WeatherIconText: View {

    var icon: WeatherIcon
    var value: Double

    @EnvironmentObject private var appModel: AppModel

    var body: some View {
        HStack {
            Image(icon.rawValue)
            Text(getText())
                .foregroundStyle(.white)
                .animation(nil, value: appModel.units)
        }
        .animation(.bouncy, value: appModel.units)
    }

    func getText() -> String {
        switch icon {
            case .cold:
                return "Min \(value.toSignedString())"
            case .warm:
                return "Max \(value.toSignedString())"
            case .sun:
                return value.toSignedString()
            case .rain:
                return "Rain \(value) mm"
        }
    }
}

#Preview {
    ZStack {
        BackgroundGradient().ignoresSafeArea()
        WeatherIconText(icon: .rain, value: -5)
    }
    .environmentObject(AppModel())
}
