//
//  WeatherModel.swift
//  WeatherTest
//
//  Created by Дубынин Семён on 02.08.2020.
//  Copyright © 2020 Дубынин Семён. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let feelsLikeTemp: Double
    let humidity: Int
    
    var temperatureFormat:String{
        return String(format: "%.0f", temperature)
    }
    
    var feelsLikeTempFormat:String{
        return String(format: "%.0f", feelsLikeTemp)
    }
    
    
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
