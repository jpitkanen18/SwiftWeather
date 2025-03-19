//
//  AppState.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import Foundation

enum AppState {
    case `default`
    case search
}

enum Unit {
    case celsius
    case fahrenheit
}

class AppModel: ObservableObject {
    @Published var state: AppState = .default
    @Published var units: Unit = .celsius
}
