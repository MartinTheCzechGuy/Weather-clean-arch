//
//  WeatherError.swift
//
//
//  Created by Martin on 02.10.2021.
//

import Foundation

public enum WeatherError: Error {
    case cityNotFound
    case unknownError
    case buildingRequestFailure
    case decodingError
}
