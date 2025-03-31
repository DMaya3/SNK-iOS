//
//  Information+CoreDataProperties.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//
//

import Foundation
import CoreData


extension Information {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Information> {
        return NSFetchRequest<Information>(entityName: "Information")
    }

    @NSManaged public var count: Int64
    @NSManaged public var next_page: String?
    @NSManaged public var pages: Int64
    @NSManaged public var prev_page: String?
    @NSManaged public var rootEpisodes: RootEpisodes?
    @NSManaged public var root: Root?

}

extension Information : Identifiable {

}
