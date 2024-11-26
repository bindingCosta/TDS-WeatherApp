//
//  ContentView.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 25/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    let cities = [
        City(name: "Dallol", country: "NG", latitude: 14.247, longitude: 40.296),
        City(name: "Fairbanks", country: "US", latitude: 64.8378, longitude: -147.7164),
        City(name: "London", country: "GB", latitude: 51.5074, longitude: -0.1278),
        City(name: "Recife", country: "BR", latitude: -8.0476, longitude: -34.8770),
        City(name: "Vancouver", country: "CA", latitude: 49.2827, longitude: -123.1207),
        City(name: "Yakutsk", country: "RU", latitude: 62.0282, longitude: 129.7320)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    headerView()
                    cityListView()
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Header
    private func headerView() -> some View {
        VStack {
            Text("WEATHER")
                .font(Font.custom("Poppins", size: 36))
                .foregroundColor(.white)
            
            Text("Select a city")
                .font(Font.custom("Poppins", size: 22))
                .foregroundColor(.white.opacity(0.7))
            
            Image("earth-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
        }
        .padding(.top, 130)
    }
    
    // MARK: - City List View
    private func cityListView() -> some View {
        VStack(spacing: 30) {
            cityNavigationLinks(cities: cities.prefix(3), spacing: 40)
            cityNavigationLinks(cities: cities.suffix(3), spacing: 30)
        }
        .padding(.top, 10)
    }
    
    private func cityNavigationLinks(cities: ArraySlice<City>, spacing: CGFloat) -> some View {
        HStack(spacing: spacing) {
            ForEach(cities, id: \.name) { city in
                NavigationLink(destination: WeatherDetailView(viewModel: viewModel, city: city)) {
                    Text(city.name)
                        .font(Font.custom("Poppins", size: 18))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
