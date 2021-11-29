//
//  CitySearcherAssembly.swift
//
//
//  Created by Martin on 01.10.2021.
//

import Swinject
import SwinjectAutoregistration

public class CitySearcherAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.autoregister(CurrentWeatherRepositoryType.self, initializer: CurrentWeatherRepository.init)
        container.autoregister(GetWeatherForCityUseCaseType.self, initializer: GetWeatherForCityUseCase.init)
    }
}
