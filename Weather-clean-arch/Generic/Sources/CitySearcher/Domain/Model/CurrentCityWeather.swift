//
//  CurrentCityWeather.swift
//
//
//  Created by Martin on 02.10.2021.
//

import Foundation

public struct CurrentCityWeather: Identifiable, Hashable {
    public let id = UUID()
    public let city: String
    public let currentWeather: CurrentWeather
    public let description: String
    public let temperature: Double
    public let pressure: Double
    public let humidity: Double
}
