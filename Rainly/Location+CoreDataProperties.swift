//
//  Location+CoreDataProperties.swift
//  Rainly
//
//  Created by Ruslan Leteyski on 10/4/16.
//  Copyright © 2016 Leteyski. All rights reserved.
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location");
    }

    @NSManaged public var city: String?

}
