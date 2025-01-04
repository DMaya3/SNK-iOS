//
//  Titans+CoreDataClass.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 04/01/2025.
//
//

import Foundation
import CoreData

@objc(Titans)
public class Titans: NSManagedObject, NSSecureCoding, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case img_titan = "img"
        case height
        case abilities
        case current_inheritor
        case former_inheritors
        case allegiance
    }
    
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: CodingKeys.id.rawValue)
        coder.encode(self.name, forKey: CodingKeys.name.rawValue)
        coder.encode(self.img_titan, forKey: CodingKeys.img_titan.rawValue)
        coder.encode(self.height, forKey: CodingKeys.height.rawValue)
        coder.encode(self.abilities, forKey: CodingKeys.abilities.rawValue)
        coder.encode(self.current_inheritor, forKey: CodingKeys.current_inheritor.rawValue)
        coder.encode(self.former_inheritors, forKey: CodingKeys.former_inheritors.rawValue)
        coder.encode(self.allegiance, forKey: CodingKeys.allegiance.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Titans", in: context) else {
            return nil
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.id = coder.decodeInt64(forKey: CodingKeys.id.rawValue)
        self.name = coder.decodeObject(forKey: CodingKeys.name.rawValue) as? String
        self.img_titan = coder.decodeObject(forKey: CodingKeys.img_titan.rawValue) as? Data
        self.height = coder.decodeObject(forKey: CodingKeys.height.rawValue) as? String
        self.abilities = coder.decodeObject(forKey: CodingKeys.abilities.rawValue) as? [String]
        self.current_inheritor = coder.decodeObject(forKey: CodingKeys.current_inheritor.rawValue) as? String
        self.former_inheritors = coder.decodeObject(forKey: CodingKeys.former_inheritors.rawValue) as? [String]
        self.allegiance = coder.decodeObject(forKey: CodingKeys.allegiance.rawValue) as? String
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Titans", in: context) else {
            throw CoreDataErrors.entityNotFound
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        if let imgUrlString = try? container.decode(String.self, forKey: .img_titan), let imgUrl = URL(string: imgUrlString) {
            self.img_titan = try? Data(contentsOf: imgUrl)
        }
        self.height = try container.decode(String.self, forKey: .height)
        self.abilities = try container.decode([String].self, forKey: .abilities)
        self.current_inheritor = try container.decode(String.self, forKey: .current_inheritor)
        self.former_inheritors = try container.decode([String].self, forKey: .former_inheritors)
        self.allegiance = try container.decode(String.self, forKey: .allegiance)
    }
}
