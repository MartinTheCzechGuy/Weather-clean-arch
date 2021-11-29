//
//  CurrentWeatherEntity.swift
//
//
//  Created by Martin on 02.10.2021.
//

struct CurrentWeatherEntity: Decodable {
    let city: String
    let currentWeather: WeatherCode
    let description: String
    let data: WeatherData
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case weather
        case data = "main"
    }
    
    init(
        city: String,
        currentWeather: WeatherCode,
        description: String,
        data: WeatherData
    ) {
        self.city = city
        self.currentWeather = currentWeather
        self.description = description
        self.data = data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        city = try values.decode(String.self, forKey: .city)
        data = try values.decode(WeatherData.self, forKey: .data)
        
        let description = try values.decode([WeatherDescription].self, forKey: .weather).first
        
        currentWeather = description
            .map(\.id)
            .map {
                switch $0 {
                case 200..<300: return .thunderstorm
                case 300..<400: return .drizzle
                case 500..<600: return .rain
                case 600..<700: return .snow
                case 700..<800: return .mist
                case 801..<900: return .clouds
                default: return .clear
                }
            } ?? .clear
        
        self.description = description.map(\.description) ?? "No weather description."
    }
    
    struct WeatherDescription: Decodable {
        let id: Int
        let main: String
        let description: String
    }
    
    struct WeatherData: Decodable {
        let temp: Double
        let pressure: Double
        let humidity: Double
    }
}
