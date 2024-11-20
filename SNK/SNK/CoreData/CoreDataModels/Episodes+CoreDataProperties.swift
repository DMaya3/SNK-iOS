//
//  Episodes+CoreDataProperties.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//
//

import Foundation
import CoreData


extension Episodes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Episodes> {
        return NSFetchRequest<Episodes>(entityName: "Episodes")
    }

    @NSManaged public var characters: [String]?
    @NSManaged public var episode: String?
    @NSManaged public var id: Int64
    @NSManaged public var img: Data?
    @NSManaged public var name: String?
    @NSManaged public var rootEpisodes: RootEpisodes?

}

extension Episodes : Identifiable {

}
