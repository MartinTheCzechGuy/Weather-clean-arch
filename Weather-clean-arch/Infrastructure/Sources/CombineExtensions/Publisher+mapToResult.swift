//
//  Publisher+mapToResult.swift
//
//
//  Created by Martin on 01.10.2021.
//

import Combine

public extension Publisher {
    func mapToResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self
            .map(Result.success)
            .catch { Just(Result.failure($0)) }
            .eraseToAnyPublisher()
    }
}
