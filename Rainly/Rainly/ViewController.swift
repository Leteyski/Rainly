//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 4/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

extension CurrentWeather {
    var temperatureString: String {
        return "\(Int(temperatureInCelsius))º"
    }
    
    var humidityString: String {
        let percantageValue = Int(humidity * 100)
        return "\(percantageValue)%"
    }
    
    var precipProbabilityString: String {
        let percantageValue = Int(precipProbability * 100)
        return "\(percantageValue)%"
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let forecastAPIKey = "be76ceb070951d187c7a1cb87737badb"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let icon = WeatherIcon.Rain.image
        let currentWeather = CurrentWeather(temperature: 56.0, humidity: 0.8, precipProbability: 1.0, summary: "Wet and rainy!", icon: icon)
        display(currentWeather)
        
        
        // https://api.darksky.net/forecast/be76ceb070951d187c7a1cb87737badb/37.8267,-122.4233

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func display(weather: CurrentWeather) {
        currentTemperatureLabel.text = weather.temperatureString
        currentHumidityLabel.text = weather.humidityString
        currentPrecipitationLabel.text = weather.precipProbabilityString
        currentSummaryLabel.text = weather.summary
        currentWeatherIcon.image = weather.icon
    }

}

