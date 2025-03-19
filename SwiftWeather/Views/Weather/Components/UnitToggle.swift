//
//  UnitToggle.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import SwiftUI

struct UnitToggle: View {

    @EnvironmentObject private var appModel: AppModel

    var alignment: Alignment {
        switch appModel.units {
            case .celsius: return .trailing
            case .fahrenheit: return .leading
        }
    }

    var color: Color {
        switch appModel.units {
            case .celsius: return Color.pastelGreen
            case .fahrenheit: return Color.gray
        }
    }

    var opacityCelsius: Double {
        switch appModel.units {
            case .celsius: return 1.0
            case .fahrenheit: return 0.0
        }
    }

    var opacityFahrenheit: Double {
        switch appModel.units {
            case .celsius: return 0.0
            case .fahrenheit: return 1.0
        }
    }

    var body: some View {
        ZStack(alignment: alignment) {
            Capsule()
                .fill(color)
                .frame(width: 65.0, height: 30.0)
                .animation(.easeInOut, value: appModel.units)
            HStack {
                Text("C°")
                    .opacity(opacityCelsius)
                    .animation(.easeInOut, value: appModel.units)
                Spacer()
                Text("F°")
                    .opacity(opacityFahrenheit)
                    .animation(.easeInOut, value: appModel.units)
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10.0))
            .frame(width: 65.0, height: 30.0)
            Circle().fill(Color.white)
                .frame(width: 28.0, height: 28.0)
                .padding(EdgeInsets(top: 0, leading: 1, bottom: 0, trailing: 3.0))
                .animation(.easeInOut, value: appModel.units)
        }
        .onTapGesture {
            switch appModel.units {
                case .celsius:
                    appModel.units = .fahrenheit
                case .fahrenheit:
                    appModel.units = .celsius
            }
        }

    }
}

#Preview {
    UnitToggle().environmentObject(AppModel())
}
