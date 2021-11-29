//
//  InstanceProvider.swift
//
//
//  Created by Martin on 01.10.2021.
//

public protocol InstanceProvider {
    func resolve<Instance>(_ ofType: Instance.Type) -> Instance
}
