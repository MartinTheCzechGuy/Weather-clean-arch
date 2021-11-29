import Combine
import XCTest
@testable import CitySearcher
import SwiftUI

final class CurrentWeatherRepositoryStub: CurrentWeatherRepositoryType {
    
    private let result: AnyPublisher<CurrentWeatherEntity, WeatherError>
    
    init(result: AnyPublisher<CurrentWeatherEntity, WeatherError>) {
        self.result = result
    }
    
    func currentWeather(for city: String) -> AnyPublisher<CurrentWeatherEntity, WeatherError> {
        result
    }
}

final class GetWeatherForCityUseCaseTests: XCTestCase {
    
    private var bag = Set<AnyCancellable>()
    
    func test_fetch_weather_success() {
        let weather = CurrentWeatherEntity(
            city: "city",
            currentWeather: .clear,
            description: "desc",
            data: .init(temp: 10, pressure: 20, humidity: 30)
        )
        let repository = CurrentWeatherRepositoryStub(
            result: Just(weather).setFailureType(to: WeatherError.self).eraseToAnyPublisher()
        )
        let useCase = GetWeatherForCityUseCase(repository: repository)
        
        let expectation = expectation(description: "Should have receive a weather model")
        
        useCase.weather(for: "city")
            .sink(
                receiveCompletion: { completion in
                    guard case .failure = completion else { return }
                
                    XCTFail()
                },
                receiveValue: { result in
                    XCTAssertEqual(result.city, weather.city)
                    XCTAssertEqual(result.currentWeather, .clear)
                    XCTAssertEqual(result.description, weather.description)
                    XCTAssertEqual(result.temperature, weather.data.temp)
                    XCTAssertEqual(result.pressure, weather.data.pressure)
                    XCTAssertEqual(result.humidity, weather.data.humidity)

                    expectation.fulfill()
                }
            )
            .store(in: &bag)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_fetch_weather_failure() {
        let weather = CurrentWeatherEntity(
            city: "city",
            currentWeather: .clear,
            description: "desc",
            data: .init(temp: 10, pressure: 20, humidity: 30)
        )
        let repository = CurrentWeatherRepositoryStub(
            result: Fail<CurrentWeatherEntity, WeatherError>(error: .buildingRequestFailure).eraseToAnyPublisher()
        )
        let useCase = GetWeatherForCityUseCase(repository: repository)
        
        let expectation = expectation(description: "Should have receive an error")
        
        useCase.weather(for: "city")
            .sink(
                receiveCompletion: { completion in
                    guard case .failure = completion else {
                        XCTFail()
                        return
                    }
                
                    expectation.fulfill()
                },
                receiveValue: { result in
                    XCTFail()
                }
            )
            .store(in: &bag)
        
        waitForExpectations(timeout: 0.1)
    }
}
