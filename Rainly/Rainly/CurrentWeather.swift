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

