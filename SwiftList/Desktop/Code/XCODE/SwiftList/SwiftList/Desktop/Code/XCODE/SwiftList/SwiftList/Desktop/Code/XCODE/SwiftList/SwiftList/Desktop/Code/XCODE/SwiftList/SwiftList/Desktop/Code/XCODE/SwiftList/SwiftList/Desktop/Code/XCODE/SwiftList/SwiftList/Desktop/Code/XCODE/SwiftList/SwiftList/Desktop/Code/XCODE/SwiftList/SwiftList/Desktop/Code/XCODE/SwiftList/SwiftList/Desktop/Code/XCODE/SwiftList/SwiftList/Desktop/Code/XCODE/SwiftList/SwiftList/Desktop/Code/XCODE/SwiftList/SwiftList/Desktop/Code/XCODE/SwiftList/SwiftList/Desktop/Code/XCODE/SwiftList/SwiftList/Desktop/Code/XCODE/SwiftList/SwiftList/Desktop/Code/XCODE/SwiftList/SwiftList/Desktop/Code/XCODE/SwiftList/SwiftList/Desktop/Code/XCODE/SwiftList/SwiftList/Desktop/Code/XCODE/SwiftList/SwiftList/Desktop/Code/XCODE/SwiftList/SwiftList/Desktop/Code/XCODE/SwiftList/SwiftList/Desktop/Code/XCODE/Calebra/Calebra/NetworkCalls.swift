//
//  NetworkCalls.swift
//  Calebra
//
//  Created by Rohil on 7/23/20.
//  Copyright © 2020 Calebra Inc. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON



public class NetworkCalls {
    public static func getCurrentWeatherData(lat: Double, long: Double, completion: @escaping (Result<WeatherData, NSError>) -> Void) {
        let key = "f713ed814b44d28f20abc74aaeceb8d7"
        let url = "https://api.openweathermap.org/data/2.5/weather?appid=\(key)&lat=\(lat)&lon=\(long)&units=imperial"
        
        AF.request(url).response { result in
            if let err = result.error {
                completion(.failure(NSError(domain: "com.calebra", code: 0, userInfo: [NSLocalizedDescriptionKey: err.localizedDescription])))
            }
            
            let data = JSON(result.data!)
            print(data)
            
             let temp = data["main"]["temp"].doubleValue
             let city = data["name"].stringValue
             let country = data["sys"]["country"].stringValue
             let wind = data["wind"]["speed"].doubleValue
             let description = data["weather"][0]["description"].stringValue
             let minTemp = data["main"]["temp_min"].doubleValue
             let maxTemp = data["main"]["temp_max"].doubleValue
             
             
             let weatherData = WeatherData(temp: temp, city: city, country: country, wind: wind, description: description, minTemp: minTemp, maxTemp: maxTemp)
             completion(.success(weatherData))
             
        }
    }
}

public class WeatherData {
    // city, country, wind speed, description, min temp, max temp
    var temperature: Double
    var city: String
    var country: String
    var wind: Double
    var description: String
    var minTemp: Double
    var maxTemp: Double
    
    init(temp: Double, city: String, country: String, wind: Double, description: String, minTemp: Double, maxTemp: Double) {
        temperature = temp
        self.city = city
        self.country = country
        self.wind = wind
        self.description = description
        self.minTemp = minTemp
        self.maxTemp = maxTemp
    }
}
