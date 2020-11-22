//
//  WeatherData.swift
//  Weather
//
//  Created by Гусейн Агаев on 20.11.2020.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    
    // MARK: - Weather
    struct Weather: Codable {
        let icon: String
    }

    // MARK: - Main
    struct Main: Codable {
        let temp: Double
    }
    
    // MARK: - Public Properties
    
    let name: String
    let main: Main
    let weather: [Weather]
    
    var imageURL: String {
        String("https://openweathermap.org/img/wn/\(weather.first?.icon ?? "")@2x.png")
    }
}
