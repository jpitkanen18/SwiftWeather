//
//  SearchItem.swift
//  SwiftWeather
//
//  Created by Jese on 19.3.2025.
//

import SwiftUI

struct SearchItem: View {
    @Binding var searchInput: String
    var geocodingItem: GeocodingResponse
    var body: some View {
        HStack {
            Text(
                LocalizedStringKey(
                    geocodingItem.displayString
                        .highlightInput(input: searchInput)
                )
            )
                .font(Font.system(size: 16))
                .foregroundStyle(.white)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 50, bottom: 17, trailing: 0))
    }
}

#Preview {
    ZStack {
        BackgroundGradient().ignoresSafeArea()
        SearchItem(searchInput: .constant("Tu"), geocodingItem:
                    GeocodingResponse(name: "Turku", localNames: nil, lat: 24, lon: 25, country: "Finland", state: nil))
    }
}
