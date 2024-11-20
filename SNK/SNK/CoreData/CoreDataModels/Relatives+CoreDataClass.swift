//
//  Relatives+CoreDataClass.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//
//

import Foundation
import CoreData

@objc(Relatives)
public class Relatives: NSManagedObject, NSSecureCoding, Decodable {
    enum CodingKeys: String, CodingKey {
        case family
        case members
    }
    
    public static var supportsSecureCoding: Bool {
        return true
    }

    public required convenience init?(coder: NSCoder) {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Relatives", in: context) else {
            return nil
        }
        self.init(entity: entity, insertInto: context)

        self.family = coder.decodeObject(forKey: CodingKeys.family.rawValue) as? String
        self.members = coder.decodeObject(forKey: CodingKeys.members.rawValue) as? [String] ?? []
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.family, forKey: CodingKeys.family.rawValue)
        coder.encode(self.members, forKey: CodingKeys.members.rawValue)
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Relatives", in: context) else {
            throw CoreDataErrors.entityNotFound
        }
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.family = try container.decode(String.self, forKey: .family)
        self.members = try container.decode([String].self, forKey: .members)
    }
}
