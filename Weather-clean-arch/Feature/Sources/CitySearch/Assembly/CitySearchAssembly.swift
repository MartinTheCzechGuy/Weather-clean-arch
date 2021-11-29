//
//  CitySearchAssembly.swift
//
//
//  Created by Martin on 01.10.2021.
//

import Swinject
import SwinjectAutoregistration

public class CitySearchAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.autoregister(CitySearchViewModel.self, initializer: CitySearchViewModel.init)
        container.autoregister(CityDetailView.self, initializer: CityDetailView.init)
        container.autoregister(CitySearchView.self, initializer: CitySearchView.init)
    }
}
