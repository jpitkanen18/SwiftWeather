//
//  SearchResults.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import SwiftUI

struct SearchResults: View {
    @EnvironmentObject var weatherModel: WeatherModel
    @EnvironmentObject var appModel: AppModel

    var body: some View {
        ScrollView {
            VStack(alignment: .trailing) {
                if weatherModel.geocodingResults != nil, weatherModel.geocodingResults?.isEmpty ?? true {
                    Text("No results").font(Font.system(size: 30))
                        .foregroundStyle(.white)
                } else {
                    ForEach(
                        0..<(weatherModel.geocodingResults?.count ?? 0),
                        id: \.self
                    ) { index in
                        SearchItem(
                            searchInput: $weatherModel.searchString,
                            geocodingItem: weatherModel.geocodingResults![index]
                        )
                        .onTapGesture {
                            weatherModel.searchString = ""
                            weatherModel.selectedCity = weatherModel.geocodingResults![index]
                            appModel.state = .default
                        }
                    }
                }
            }
            .animation(.bouncy, value: (weatherModel.geocodingResults ?? []).count)
        }
    }
}

#Preview {
    ZStack {
        BackgroundGradient().ignoresSafeArea()
        SearchResults()
    }

}
