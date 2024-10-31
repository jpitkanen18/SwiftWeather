//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//
import SwiftUI
import Combine

struct SearchBar: View {
    
    @Binding var searchWeather: Bool
    @Binding var searchString: String
    @Binding var inSearchMode: Bool
    @EnvironmentObject var weatherAPI: WeatherAPI
    let searchStringPublisher = PassthroughSubject<String, Never>()
    
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
                    TextField("Search country, region, city", text: $searchString)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        .onChange(of: searchString, {oldString, newString in
                            searchWeather = false
                            if newString.isEmpty{
                                return
                            }
                            if !inSearchMode {
                                inSearchMode = true
                            }
                            searchStringPublisher.send(newString)
                        })
                        .onReceive(searchStringPublisher.debounce(for: .milliseconds(200), scheduler: DispatchQueue.main), perform: { newSearchString in
                            self.weatherAPI.cancelGeocodingTasks()
                            self.weatherAPI.fetchLocationsUI(searchString: newSearchString)
                        })
                        
                    Image("Delete")
                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 20))
                        .opacity(searchString.isEmpty ? 0 : 1)
                        .animation(.bouncy, value: searchString)
                        .onTapGesture {
                            searchString = ""
                        }
                }
            }.animation(.bouncy, value: inSearchMode)
            if(inSearchMode) {
                Button(action: {
                    searchString = ""
                    inSearchMode = false
                    searchWeather = false
                    weatherAPI.revertToHome()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
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
    SearchBar(searchWeather: .constant(false), searchString: .constant("Turku"), inSearchMode: .constant(true))
}


