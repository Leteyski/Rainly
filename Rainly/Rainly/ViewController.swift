//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 4/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import CoreLocation

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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let forecastAPIClient = ForecastAPIClient(APIKey: "be76ceb070951d187c7a1cb87737badb")
    var coordinate = Coordinate(latitude: 0, longtitude: 0)
    var locationManager: CLLocationManager!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        //TODO: Wrapup in a function & call when refresh
        //TODO: Show the correct location label
       
}
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fetchCurrentWeather() {
        forecastAPIClient.fetchCurrentWeather(coordinate) { result in
            
            self.toggleRefreshAnimation(false)
            
            switch result {
                
            case .Success(let currentWeather):
                self.display(currentWeather)
                
            case .Failure(let error as NSError):
                self.showAlert("Unable to retreive forecast!", message: error.localizedDescription)
                
            default: break
                
            }
        }
    }
    
    func display(weather: CurrentWeather) {
        currentTemperatureLabel.text = weather.temperatureString
        currentHumidityLabel.text = weather.humidityString
        currentPrecipitationLabel.text = weather.precipProbabilityString
        currentSummaryLabel.text = weather.summary
        currentWeatherIcon.image = weather.icon
    }
    
    func showAlert(title: String, message: String?, style: UIAlertControllerStyle = .Alert) {
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: style)
        let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertControler.addAction(dismissAction)
        
        presentViewController(alertControler, animated: true, completion: nil)
        
    }

    @IBAction func refreshWeather(sender: AnyObject) {
        toggleRefreshAnimation(true)
        fetchCurrentWeather()
    }
    
    func toggleRefreshAnimation(on: Bool) {
        refreshButton.hidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        
        coordinate.latitude = location.coordinate.latitude
        coordinate.longtitude = location.coordinate.longitude
        
        print("Coordinates Changed to \(coordinate.latitude),\(coordinate.longtitude) :)")
        
        locationManager.stopUpdatingLocation()
        
        fetchCurrentWeather()
    }

    }



