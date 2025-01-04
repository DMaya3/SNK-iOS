//
//  RootTitan+CoreDataProperties.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 04/01/2025.
//
//

import Foundation
import CoreData


extension RootTitan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RootTitan> {
        return NSFetchRequest<RootTitan>(entityName: "RootTitan")
    }

    @NSManaged public var info: Information?
    @NSManaged public var results: [Titans]?
    @NSManaged public var toInfo: Information?
    @NSManaged public var toResults: Titans?

}

extension RootTitan : Identifiable {

}
