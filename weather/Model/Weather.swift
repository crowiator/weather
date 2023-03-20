//
//  Weather.swift
//  weather
//Program bol vytvoreny v rámci kurzu na portali skillmea.sk
//  Created by crow on 20/03/2023.
//

import Foundation

struct WeatherMain: Codable {
    let lat: Double
    let lon: Double
    let current: WeatherCurrent
    let daily: [WeatherDaily]
    
    struct WeatherCurrent: Codable {
        let temp: Double
        let feels_like: Double
        let weather: [WeatherDescription]
        
        struct WeatherDescription: Codable {
            let main: String
            let icon: String
        }
    }
    
    struct WeatherDaily: Codable {
        let dt: Int
        let temp: DailyTemp
        let weather: [DailyDescription]
        
        struct DailyTemp: Codable {
            let day: Double
        }
        
        struct DailyDescription: Codable {
            let icon: String
        }
    }
}
