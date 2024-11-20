//
//  Relatives+CoreDataProperties.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//
//

import Foundation
import CoreData


extension Relatives {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Relatives> {
        return NSFetchRequest<Relatives>(entityName: "Relatives")
    }

    @NSManaged public var family: String?
    @NSManaged public var members: [String]?

}

extension Relatives : Identifiable {

}
