//
//  CitySearchView.swift
//
//
//  Created by Martin on 01.10.2021.
//

import Combine
import UIKit
import SwiftUI

public struct CitySearchView: View {
    
    @ObservedObject var viewModel: CitySearchViewModel
    
    public init(viewModel: CitySearchViewModel) {
        self.viewModel = viewModel
        
        UITableView.appearance().backgroundColor = .none
    }
    
    public var body: some View {
        if viewModel.showLoading {
            ProgressView(label: { Text("Loading data...") })
        } else {
            NavigationView {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Enter city name...", text: $viewModel.city)
                    }
                    .padding(10)
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    Color(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, opacity: 1)
                                ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(20)
                    
                    if (!viewModel.results.isEmpty) {
                        HStack {
                            VStack { Divider().background(Color.black) }.padding(10)
                            Text("Results").foregroundColor(.black)
                            VStack { Divider().background(Color.black) }.padding(10)
                        }
                        .padding()
                    }
                
                    List {
                        ForEach(viewModel.results, id: \.self) { weather in
                            NavigationLink(
                                destination: CityDetailView(
                                    background: weather.currentWeather.background,
                                    iconName: weather.currentWeather.icon,
                                    description: weather.description,
                                    temperature: weather.temperature,
                                    pressure: weather.pressure,
                                    humidity: weather.humidity,
                                    city: weather.city
                                ),
                                label: {
                                    HStack {
                                        Text(weather.city)
                                        Spacer()
                                        Text("\(String(format: "%.1f", weather.temperature)) ℃")
                                    }
                                }
                            )
                            .listRowBackground(weather.currentWeather.background)
                            .padding()
                        }
                    }
                }
                .alert(isPresented: $viewModel.showError) { () -> Alert in
                    Alert(
                        title: Text("The city name \(viewModel.city) not found. Please try a different search."),
                        dismissButton: .default(Text("OK"), action: { viewModel.hideErrorClick.send() })
                    )
                }
                .padding()
                .navigationTitle("Search")
                .navigationViewStyle(StackNavigationViewStyle())
                .background(Color(.systemGroupedBackground).ignoresSafeArea())
            }
        }
    }
}

