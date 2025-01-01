//
//  Groups+CoreDataProperties.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 11/12/2024.
//
//

import Foundation
import CoreData


extension Groups {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Groups> {
        return NSFetchRequest<Groups>(entityName: "Groups")
    }

    @NSManaged public var name: String?
    @NSManaged public var sub_groups: [String]?

}

extension Groups : Identifiable {

}
