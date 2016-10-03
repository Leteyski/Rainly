//
//  ForecastClient.swift
//  Rainly
//
//  Created by Ruslan Leteyski on 03/10/2016.
//  Copyright © 2016 Leteyski. All rights reserved.
//

import Foundation


final class ForecastAPIClient: APIClient {
    
    let configuration: NSURLSessionConfiguration
    lazy var session: NSURLSession = {
        return NSURLSession(configuration: self.configuration)
    }()
    
    private let token: String
    
    init(config: NSURLSessionConfiguration, APIKey: String) {
        self.configuration = config
        self.token = APIKey
    }
    
    convenience init(APIKey: String) {
        self.init(config: NSURLSessionConfiguration.defaultSessionConfiguration(), APIKey: APIKey)
    }
    
    
    
}
