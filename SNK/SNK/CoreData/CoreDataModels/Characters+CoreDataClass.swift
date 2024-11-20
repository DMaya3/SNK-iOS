//
//  Characters+CoreDataClass.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//
//

import Foundation
import CoreData

@objc(Characters)
public class Characters: NSManagedObject, NSSecureCoding, Decodable, ArrayConvertible {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case img
        case alias
        case species
        case gender
        case age
        case height
        case relatives
        case birthplace
        case residence
        case status
        case occupation
        case groups
        case roles
        case episodes
    }
    
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    public static var entity: NSEntityDescription {
        NSEntityDescription.entity(forEntityName: "Characters", in: CoreDataProvider.preview.context) ?? NSEntityDescription()
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: CodingKeys.id.rawValue)
        coder.encode(self.name, forKey: CodingKeys.name.rawValue)
        coder.encode(self.img, forKey: CodingKeys.img.rawValue)
        coder.encode(self.alias, forKey: CodingKeys.alias.rawValue)
        coder.encode(self.species, forKey: CodingKeys.species.rawValue)
        coder.encode(self.gender, forKey: CodingKeys.gender.rawValue)
        coder.encode(self.age, forKey: CodingKeys.age.rawValue)
        coder.encode(self.height, forKey: CodingKeys.height.rawValue)
        coder.encode(self.relatives, forKey: CodingKeys.relatives.rawValue)
        coder.encode(self.birthplace, forKey: CodingKeys.birthplace.rawValue)
        coder.encode(self.residence, forKey: CodingKeys.residence.rawValue)
        coder.encode(self.status, forKey: CodingKeys.status.rawValue)
        coder.encode(self.occupation, forKey: CodingKeys.occupation.rawValue)
        coder.encode(self.groups, forKey: CodingKeys.groups.rawValue)
        coder.encode(self.roles, forKey: CodingKeys.roles.rawValue)
        coder.encode(self.episodes, forKey: CodingKeys.episodes.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Characters", in: context) else {
            return nil
        }

        self.init(entity: entity, insertInto: context)
        
        self.id = coder.decodeInt64(forKey: CodingKeys.id.rawValue)
        self.name = coder.decodeObject(forKey: CodingKeys.name.rawValue) as? String
        self.img = coder.decodeObject(forKey: CodingKeys.img.rawValue) as? Data
        self.alias = coder.decodeObject(forKey: CodingKeys.alias.rawValue) as? [String]
        self.species = coder.decodeObject(forKey: CodingKeys.species.rawValue) as? [String]
        self.gender = coder.decodeObject(forKey: CodingKeys.gender.rawValue) as? String
        self.age = coder.decodeInt64(forKey: CodingKeys.age.rawValue)
        self.height = coder.decodeObject(forKey: CodingKeys.height.rawValue) as? String
        self.relatives = coder.decodeObject(forKey: CodingKeys.relatives.rawValue) as? [Relatives]
        self.birthplace = coder.decodeObject(forKey: CodingKeys.birthplace.rawValue) as? String
        self.residence = coder.decodeObject(forKey: CodingKeys.residence.rawValue) as? String
        self.status = coder.decodeObject(forKey: CodingKeys.status.rawValue) as? String
        self.occupation = coder.decodeObject(forKey: CodingKeys.occupation.rawValue) as? String
        self.groups = coder.decodeObject(forKey: CodingKeys.groups.rawValue) as? [Groups]
        self.roles = coder.decodeObject(forKey: CodingKeys.roles.rawValue) as? [String]
        self.episodes = coder.decodeObject(forKey: CodingKeys.episodes.rawValue) as? [String]
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Characters", in: context) else {
            throw CoreDataErrors.entityNotFound
        }

        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        if let imgUrlString = try? container.decode(String.self, forKey: .img), let imgUrl = URL(string: imgUrlString) {
            self.img = try? Data(contentsOf: imgUrl)
        }
        self.alias = try container.decode([String].self, forKey: .alias)
        self.species = try container.decode([String].self, forKey: .species)
        self.gender = try container.decode(String.self, forKey: .gender)
        if let ageInt = try? container.decode(Int64.self, forKey: .age) {
            self.age = ageInt
        } else if let ageString = try? container.decode(String.self, forKey: .age), let ageFromString = Int64(ageString) {
            self.age = ageFromString
        } else {
            self.age = 0
        }
        self.height = try container.decode(String.self, forKey: .height)
        self.relatives = try container.decode([Relatives].self, forKey: .relatives)
        self.birthplace = try container.decode(String.self, forKey: .birthplace)
        self.residence = try container.decode(String.self, forKey: .residence)
        self.status = try container.decode(String.self, forKey: .status)
        self.occupation = try container.decode(String.self, forKey: .occupation)
        self.groups = try container.decode([Groups].self, forKey: .groups)
        self.roles = try container.decode([String].self, forKey: .roles)
        self.episodes = try container.decode([String].self, forKey: .episodes)
    }
}
