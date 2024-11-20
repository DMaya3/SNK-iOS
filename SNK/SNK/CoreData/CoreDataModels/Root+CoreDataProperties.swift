//
//  Root+CoreDataProperties.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//
//

import Foundation
import CoreData


extension Root {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Root> {
        return NSFetchRequest<Root>(entityName: "Root")
    }

    @NSManaged public var info: Information?
    @NSManaged public var results: [Characters]?
    @NSManaged public var information: Information?
    @NSManaged public var characters: Characters?

}

extension Root : Identifiable {

}
