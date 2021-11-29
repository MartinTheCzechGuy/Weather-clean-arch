//
//  CurrentWeatherRepositoryType.swift
//
//
//  Created by Martin on 02.10.2021.
//

import Combine

protocol CurrentWeatherRepositoryType {
    func currentWeather(for city: String) -> AnyPublisher<CurrentWeatherEntity, WeatherError>
}
