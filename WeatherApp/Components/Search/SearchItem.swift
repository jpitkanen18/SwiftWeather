//
//  SearchItem.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//

import SwiftUI

struct SearchItem: View {
    @Binding var searchInput: String
    var geocodingItem: Geocoding
    var body: some View {
        HStack{
            Text(LocalizedStringKey(geocodingItem.buildDisplayString().highlightInput(input: searchInput)))
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
        SearchItem(searchInput: .constant("Tu"), geocodingItem: Geocoding(name: "Turku", localNames: nil, lat: 24, lon: 25, country: "Finland", state: nil))
    }
}
