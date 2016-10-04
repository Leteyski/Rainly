//
//  CurrentWeather.swift
//  Rainly
//
//  Created by Ruslan Leteyski on 10/3/16.
//  Copyright © 2016 Leteyski. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let humidity: Double
    let precipProbability: Double
    let summary: String
    let icon: UIImage
}

extension CurrentWeather {
    var temperatureInCelsius: Double {
        return (temperature - 32) / 1.8
    }
}

extension CurrentWeather: JSONDecodable {
    init?(JSON: [String: AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double,
        let humidity = JSON["humidity"] as? Double,
        let precipProbability = JSON["precipProbability"] as? Double,
        let summary = JSON["summary"] as? String,
        let iconString =  JSON["icon"] as? String else {
            return nil
        }
        
        let icon = WeatherIcon(rawValue: iconString).image
       
        self.temperature = temperature
        self.humidity = humidity
        self.precipProbability = precipProbability
        self.summary = summary
        self.icon = icon
        
    }
}
