//
//  Titans+CoreDataProperties.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 04/01/2025.
//
//

import Foundation
import CoreData


extension Titans {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Titans> {
        return NSFetchRequest<Titans>(entityName: "Titans")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var img_titan: Data?
    @NSManaged public var height: String?
    @NSManaged public var abilities: [String]?
    @NSManaged public var current_inheritor: String?
    @NSManaged public var former_inheritors: [String]?
    @NSManaged public var allegiance: String?
    @NSManaged public var toRootTitan: RootTitan?

}

extension Titans : Identifiable {

}
