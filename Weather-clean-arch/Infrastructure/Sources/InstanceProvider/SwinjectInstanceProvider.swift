//
//  SwinjectInstanceProvider.swift
//
//
//  Created by Martin on 01.10.2021.
//

import Swinject

class SwinjectInstanceProvider: InstanceProvider {

    let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func resolve<Instance>(_ type: Instance.Type) -> Instance {
        resolver.resolve(type)!
    }
}
