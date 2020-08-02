//
//  WeatherManager.swift
//  WeatherTest
//
//  Created by Дубынин Семён on 02.08.2020.
//  Copyright © 2020 Дубынин Семён. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager,weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager  {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=dd6211c755e9810f44773564a787e3d0&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let  urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let  urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) {(data,respons,error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let feelsLikeTemp = decodedData.main.feels_like
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let humidity =  decodedData.main.humidity
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp,feelsLikeTemp: feelsLikeTemp, humidity: humidity)
            
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
