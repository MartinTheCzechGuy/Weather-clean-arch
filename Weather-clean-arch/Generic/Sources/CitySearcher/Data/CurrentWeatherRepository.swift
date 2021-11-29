//
//  CurrentWeatherRepository.swift
//
//
//  Created by Martin on 01.10.2021.
//

import Combine
import Foundation
import CombineExtensions

final class CurrentWeatherRepository: CurrentWeatherRepositoryType {
    
    struct OpenWeatherAPI {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5"
        static let apiKey = "599304f5bdc844899dec31a799dd6761"
    }
    
    func currentWeather(for city: String) -> AnyPublisher<CurrentWeatherEntity, WeatherError> {
        guard let url = currentWeatherComponents(for: city).url else {
            return Fail(error: .buildingRequestFailure).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .map(\.data)
            .mapError { error -> WeatherError in
                if error.errorCode == 404 {
                    return WeatherError.cityNotFound
                }
                
                return WeatherError.unknownError
            }
            .flatMap { data -> AnyPublisher<CurrentWeatherEntity, WeatherError> in
                let decoder = JSONDecoder()
                
                guard let weather = try? decoder.decode(CurrentWeatherEntity.self, from: data) else {
                    return Fail(error: WeatherError.decodingError).eraseToAnyPublisher()
                }
                
                return Just(weather)
                    .setFailureType(to: WeatherError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func currentWeatherComponents(for city: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/weather"
        
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: OpenWeatherAPI.apiKey)
        ]
        
        return components
    }
}
