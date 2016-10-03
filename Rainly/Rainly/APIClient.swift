//
//  APIClient.swift
//  Rainly
//
//  Created by Ruslan Leteyski on 03/10/2016.
//  Copyright © 2016 Leteyski. All rights reserved.
//

import Foundation

public let LETNetworkingErrorDomain = "com.leteyski.Rainly.NetworkingError"
public let MissingHTPPResponseError: Int = 37
public let UnexpectedResponseError: Int = 94

typealias JSON = [String:AnyObject]
typealias JSONTaskCompletion = (JSON?, NSHTTPURLResponse?, NSError?) -> Void
typealias JSONTask = NSURLSessionDataTask

enum APIResult<T> {
    case Success(T)
    case Failure(ErrorType)
}

protocol APIClient {
    var configuration: NSURLSessionConfiguration { get }
    var session: NSURLSession { get }
    
    init(config: NSURLSessionConfiguration)
    
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion) -> JSONTask
    func fetch<T>(request: NSURLRequest, parse: JSON -> T?, completion: APIResult<T> -> Void)
    
}

extension APIClient {
    
    func JSONTaskWithRequest(request: NSURLRequest, completion: JSONTaskCompletion) -> JSONTask {
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
        
            guard let HTTPResponse = response as? NSHTTPURLResponse else {
              let userInfo = [
                NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Repsonse", comment: "")
                ]
                let error = NSError(domain: LETNetworkingErrorDomain, code: MissingHTPPResponseError, userInfo: userInfo)
                
                completion(nil, nil, error)
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                        completion(json, HTTPResponse, nil)
                    } catch let error as NSError {
                        completion(nil, HTTPResponse, error)
                    }
                default: print("Received HTTP Response\(HTTPResponse.statusCode) - not handeled!")
                
                }
            }
            
        }
        
        return task
        
    }
    
    func fetch<T>(request: NSURLRequest, parse: JSON -> T?, completion: APIResult<T> -> Void) {
        let task = JSONTaskWithRequest(request) { json, response, error in
        
            guard let json = json else {
                if let error = error {
                    completion(.Failure(error))
                } else {
                   // TODO: Fix this :)
                }
                return
            }
            
            if let value = parse(json) {
                completion(.Success(value))
            } else {
                let error = NSError(domain: LETNetworkingErrorDomain, code: UnexpectedResponseError, userInfo: nil)
                completion(.Failure(error))
            }
        
        }
   
        task.resume()
    
    }
}
