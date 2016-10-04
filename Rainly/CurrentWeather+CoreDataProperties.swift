//
//  CurrentWeather+CoreDataProperties.swift
//  Rainly
//
//  Created by Ruslan Leteyski on 10/4/16.
//  Copyright © 2016 Leteyski. All rights reserved.
//

import Foundation
import CoreData


extension CurrentWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentWeather> {
        return NSFetchRequest<CurrentWeather>(entityName: "CurrentWeather");
    }

    @NSManaged public var temperature: Double
    @NSManaged public var humidity: Double
    @NSManaged public var precipProbability: Double
    @NSManaged public var summary: String?
    @NSManaged public var iconString: String?

}
