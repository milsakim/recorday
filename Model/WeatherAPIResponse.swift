//
//  WeatherAPIResponse.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/05.
//

import Foundation

struct WeatherAPIResponse: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Double
    let daily: [DailyWeather]
}

struct DailyWeather: Codable {
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let moonrise: Double
    let moonset: Double
    let moon_phase: Double
    let temp: Temp
    let feels_like: FeelsLike
    let pressure: Double
    let humidity: Double
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Double
    let wind_gust: Double
    let weather: [Weather]
    let clouds: Double
    let pop: Double
    let uvi: Double
}

struct Temp: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
    let min: Double
    let max: Double
}

struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct Weather: Codable {
    let id: Double
    let main: String
    let description: String
    let icon: String
}
