//
//  GetWeatherForCityUseCase.swift
//
//
//  Created by Martin on 02.10.2021.
//

import Combine
import Foundation

public protocol GetWeatherForCityUseCaseType {
    func weather(for: String) -> AnyPublisher<CurrentCityWeather, WeatherError>
}

final class GetWeatherForCityUseCase {
    
    private let repository: CurrentWeatherRepositoryType
    
    init(repository: CurrentWeatherRepositoryType) {
        self.repository = repository
    }
}

extension GetWeatherForCityUseCase: GetWeatherForCityUseCaseType {
    func weather(for city: String) -> AnyPublisher<CurrentCityWeather, WeatherError> {
        repository.currentWeather(for: city)
            .map { entity in
                var weatherCode: CurrentWeather
                switch entity.currentWeather {
                case .thunderstorm:
                    weatherCode = .thunderstorm
                case .drizzle:
                    weatherCode = .drizzle
                case .rain:
                    weatherCode = .rain
                case .snow:
                    weatherCode = .snow
                case .mist:
                    weatherCode = .mist
                case .clear:
                    weatherCode = .clear
                case .clouds:
                    weatherCode = .clouds
                }
                                
                return CurrentCityWeather(
                    city: entity.city,
                    currentWeather: weatherCode,
                    description: entity.description,
                    temperature: entity.data.temp,
                    pressure: entity.data.pressure,
                    humidity: entity.data.humidity
                )
            }
            .eraseToAnyPublisher()
    }
}
