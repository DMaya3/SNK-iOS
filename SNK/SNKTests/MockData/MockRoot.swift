//
//  MockRoot.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//


import CoreData
@testable import SNK

struct MockRoot {
    
    static let context: NSManagedObjectContext = CoreDataProvider().context
    
    static var root: Root? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Root", in: self.context) else {
            return nil
        }
        
        let root = Root(entity: entity, insertInto: self.context)
        root.info = MockInformation.info
        root.results = MockCharacters.charactersList
        
        return root
    }
}
