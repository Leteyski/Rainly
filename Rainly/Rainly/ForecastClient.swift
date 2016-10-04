//
//  ForecastClient.swift
//  Rainly
//
//  Created by Ruslan Leteyski on 03/10/2016.
//  Copyright © 2016 Leteyski. All rights reserved.
//

import Foundation

struct Coordinate {
    var latitude: Double
    var longtitude: Double
}

// https://api.darksky.net/forecast/be76ceb070951d187c7a1cb87737badb/37.8267,-122.4233


enum Forecast: Endpoint {
    case Current(token: String, coordinate: Coordinate)
    
    var baseURL: NSURL {
        return NSURL(string: "https://api.darksky.net")!
    }
    
    var path: String {
        switch self {
        case .Current(token: let token, coordinate: let coordinate):
            return "/forecast/\(token)/\(coordinate.latitude),\(coordinate.longtitude)"
        }
    }
    
    var request: NSURLRequest {
        let url = NSURL(string: path, relativeToURL: baseURL)!
        return NSURLRequest(URL: url)
    }
}

final class ForecastAPIClient: APIClient {
    
    let configuration: NSURLSessionConfiguration
    lazy var session: NSURLSession = {
        return NSURLSession(configuration: self.configuration)
    }()
    
    private var token: String = ""
    
    required init(config: NSURLSessionConfiguration) {
        self.configuration = config
    }
    
    convenience init(APIKey: String) {
        self.init(config: NSURLSessionConfiguration.defaultSessionConfiguration())
        self.token = APIKey
    }
    
   convenience init(APIKey: String, config: NSURLSessionConfiguration) {
        self.init(config: config)
        self.token = APIKey
    }
    
    func fetchCurrentWeather(coordinate: Coordinate, completion: APIResult<CurrentWeather> -> Void) {
        
        let request = Forecast.Current(token: self.token, coordinate: coordinate).request
        fetch(request, parse: { ( json ) -> CurrentWeather? in
            // Parse from JSON response to current weather
            if let currentWeatherDict = json["currently"] as? [String:AnyObject] {
                return CurrentWeather(JSON: currentWeatherDict)
            } else {
                return nil
            }
            
            }, completion: completion)
        
    }

    
    
}
