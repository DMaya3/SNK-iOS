//
//  MockInformation.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//


import CoreData
@testable import SNK

struct MockInformation {
    
    static let context: NSManagedObjectContext = CoreDataProvider().context
    
    static var info: Information? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Information", in: self.context) else {
            return nil
        }
        
        let info = Information(entity: entity, insertInto: self.context)
        info.count = 201
        info.pages = 11
        info.next_page = "http://apiTest.com/next_page="
        info.prev_page = nil
        
        return info
    }
}
