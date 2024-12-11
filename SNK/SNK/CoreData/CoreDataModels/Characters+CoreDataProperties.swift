//
//  Characters+CoreDataProperties.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 11/12/2024.
//
//

import Foundation
import CoreData


extension Characters {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Characters> {
        return NSFetchRequest<Characters>(entityName: "Characters")
    }

    @NSManaged public var age: Int64
    @NSManaged public var alias: [String]?
    @NSManaged public var birthplace: String?
    @NSManaged public var episodes: [String]?
    @NSManaged public var gender: String?
    @NSManaged public var groups: [Groups]?
    @NSManaged public var height: String?
    @NSManaged public var id: Int64
    @NSManaged public var img: Data?
    @NSManaged public var name: String?
    @NSManaged public var occupation: String?
    @NSManaged public var relatives: [Relatives]?
    @NSManaged public var residence: String?
    @NSManaged public var roles: [String]?
    @NSManaged public var species: [String]?
    @NSManaged public var status: String?
    @NSManaged public var root: Root?

}
