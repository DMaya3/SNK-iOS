//
//  RootTitan+CoreDataClass.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 04/01/2025.
//
//


import Foundation
import CoreData

@objc(RootTitans)
public class RootTitan: NSManagedObject, NSSecureCoding, Decodable {
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    enum CodingKeys: String, CodingKey {
        case info
        case results
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.info, forKey: CodingKeys.info.rawValue)
        coder.encode(self.results, forKey: CodingKeys.results.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "RootTitan", in: context) else {
            return nil
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.info = coder.decodeObject(of: Information.self, forKey: CodingKeys.info.rawValue)
        self.results = coder.decodeObject(forKey: CodingKeys.results.rawValue) as? [Titans]
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "RootTitan", in: context) else {
            throw CoreDataErrors.entityNotFound
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.info = try container.decode(Information.self, forKey: .info)
        self.results = try container.decode([Titans].self, forKey: .results)
    }
}
