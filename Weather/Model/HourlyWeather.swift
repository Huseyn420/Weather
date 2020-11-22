//
//  HourlyWeather.swift
//  Weather
//
//  Created by Гусейн Агаев on 22.11.2020.
//

import Foundation

// MARK: - HourlyWeather
struct HourlyWeather: Codable {
    
    // MARK: - Weather
    struct Weather: Codable {
        let icon: String
    }
    
    // MARK: - Hourly
    struct List: Codable {
        
        // MARK: - Weather
        struct Weather: Codable {
            let icon: String
        }

        // MARK: - Main
        struct Main: Codable {
            let temp: Double
            let humidity: Int
        }
        
        let main: Main
        let weather: [Weather]
        let dt: Double
        
        var imageURL: String {
            String("https://openweathermap.org/img/wn/\(weather.first?.icon ?? "")@2x.png")
        }        
    }
    
    // MARK: - Public Properties
    
    let list: [List]
}
