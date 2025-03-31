//
//  RootEpisodes+CoreDataProperties.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 11/12/2024.
//
//

import Foundation
import CoreData


extension RootEpisodes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RootEpisodes> {
        return NSFetchRequest<RootEpisodes>(entityName: "RootEpisodes")
    }

    @NSManaged public var info: Information?
    @NSManaged public var results: [Episodes]?
    @NSManaged public var informationEpisodes: Information?
    @NSManaged public var relationEpisodes: Episodes?

}

extension RootEpisodes : Identifiable {

}
