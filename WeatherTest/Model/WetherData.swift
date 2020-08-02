//
//  WetherData.swift
//  WeatherTest
//
//  Created by Дубынин Семён on 02.08.2020.
//  Copyright © 2020 Дубынин Семён. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}

struct Weather: Codable{
    let id: Int
}
