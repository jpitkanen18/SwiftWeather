//
//  SearchBar.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import SwiftUI
import Combine

struct SearchBar: View {

    @EnvironmentObject var weatherModel: WeatherModel
    @EnvironmentObject private var appModel: AppModel

    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white)
                    .stroke(Color.black)
                    .frame(height: 40.0)
                HStack {
                    Image("SearchIcon")
                        .padding(EdgeInsets(top: 2, leading: 10, bottom: 0, trailing: 0))
                    TextField("Search country, region, city", text: $weatherModel.searchString)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        .onChange(of: weatherModel.searchString, {oldString, newString in
                            if newString.isEmpty, oldString == newString {
                                return
                            }
                            if appModel.state != .search {
                                appModel.state = .search
                            }
                        })

                    Image("Delete")
                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 20))
                        .opacity(weatherModel.searchString.isEmpty ? 0 : 1)
                        .animation(.bouncy, value: weatherModel.searchString)
                        .onTapGesture {
                            weatherModel.searchString = ""
                        }
                }
        }.animation(.bouncy, value: appModel.state)
        if appModel.state == .search {
            Button(action: {
                weatherModel.searchString = ""
                weatherModel.selectedCity = nil
                appModel.state = .default
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }, label: {
                Text("Cancel")
            })
            .foregroundStyle(.white)
        }
        }
        .padding()

    }
}

#Preview {
    SearchBar().gradientBackground()
}
