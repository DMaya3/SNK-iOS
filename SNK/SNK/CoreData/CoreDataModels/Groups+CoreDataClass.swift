//
//  Groups+CoreDataClass.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 11/12/2024.
//
//

import Foundation
import CoreData

@objc(Groups)
public class Groups: NSManagedObject, NSSecureCoding, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case sub_groups = "sub_groups"
    }

    public static var supportsSecureCoding: Bool {
        return true
    }

    public required convenience init?(coder: NSCoder) {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Groups", in: context) else {
            return nil
        }
        self.init(entity: entity, insertInto: context)

        self.name = coder.decodeObject(forKey: "name") as? String
        self.sub_groups = coder.decodeObject(forKey: "sub_groups") as? [String] ?? []
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.sub_groups, forKey: "sub_groups")
    }

    public required convenience init(from decoder: Decoder) throws {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Groups", in: context) else {
            throw CoreDataErrors.entityNotFound
        }
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.sub_groups = try container.decode([String].self, forKey: .sub_groups)
    }
}
