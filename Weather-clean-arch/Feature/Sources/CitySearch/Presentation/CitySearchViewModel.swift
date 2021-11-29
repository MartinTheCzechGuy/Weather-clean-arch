//
//  CitySearchViewModel.swift
//
//
//  Created by Martin on 01.10.2021.
//

import CitySearcher
import Combine
import Foundation

public final class CitySearchViewModel: ObservableObject {
    
    // Input
    let hideErrorClick = PassthroughSubject<Void, Never>()
    
    // Output
    @Published var city = "" {
        didSet {
            if city.count > 20 && oldValue.count <= 20 {
                city = oldValue
            }
        }
    }
    @Published var results: [CurrentCityWeather] = []
    @Published var showError = false
    @Published var showLoading = false
    
    // Private
    private let getWeatherForCityUseCase: GetWeatherForCityUseCaseType
    private var bag = Set<AnyCancellable>()
    
    public init(getWeatherForCityUseCase: GetWeatherForCityUseCaseType) {
        self.getWeatherForCityUseCase = getWeatherForCityUseCase
        
        setupBindings()
    }
    
    private func setupBindings() {
        let newSearchQuery = $city
            .compactMap { $0.count == .zero ? nil : $0 }
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.global(qos: .background))
            .share()
        
        newSearchQuery
            .map { _ in true }
            .receive(on: DispatchQueue.main)
            .assign(to: \.showLoading, on: self)
            .store(in: &bag)

        newSearchQuery
            .flatMap { [weak self] city -> AnyPublisher<Result<CurrentCityWeather, WeatherError>, Never> in
                guard let self = self else {
                    return Just<Result<CurrentCityWeather, WeatherError>>(.failure(.unknownError)).eraseToAnyPublisher()
                }
                
                return self.getWeatherForCityUseCase.weather(for: city)
                    .mapToResult()
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {_ in },
                receiveValue: { [weak self] result in
                    guard let self = self else { return }
                    
                    self.showLoading = false
                                        
                    switch result {
                    case .success(let currentWeater):
                        self.results = [currentWeater]
                    case .failure(_):
                        self.results = []
                        self.showError = true
                    }
                }
            )
            .store(in: &bag)
        
        hideErrorClick
            .map { _ in false }
            .assign(to: \.showError, on: self)
            .store(in: &bag)
    }
}
