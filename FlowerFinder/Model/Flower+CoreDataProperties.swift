//
//  Flower+CoreDataProperties.swift
//  
//
//  Created by User on 07/05/2019.
//
//

import Foundation
import CoreData


extension Flower {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flower> {
        return NSFetchRequest<Flower>(entityName: "Flower")
    }

    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var details: String?
    @NSManaged public var date: NSDate?

}
