//
//  Episodes+CoreDataClass.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//
//

import Foundation
import CoreData

@objc(Episodes)
public class Episodes: NSManagedObject, NSSecureCoding, Decodable, ArrayConvertible {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case img
        case episode
        case characters
    }
    
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    public static var entity: NSEntityDescription {
        NSEntityDescription.entity(forEntityName: "Episodes", in: CoreDataProvider.preview.context) ?? NSEntityDescription()
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: CodingKeys.id.rawValue)
        coder.encode(self.name, forKey: CodingKeys.name.rawValue)
        coder.encode(self.img, forKey: CodingKeys.img.rawValue)
        coder.encode(self.episode, forKey: CodingKeys.episode.rawValue)
        coder.encode(self.characters, forKey: CodingKeys.characters.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Episodes", in: context) else {
            return nil
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.id = coder.decodeInt64(forKey: CodingKeys.id.rawValue)
        self.name = coder.decodeObject(forKey: CodingKeys.name.rawValue) as? String
        self.img = coder.decodeObject(forKey: CodingKeys.img.rawValue) as? Data
        self.episode = coder.decodeObject(forKey: CodingKeys.episode.rawValue) as? String
        self.characters = coder.decodeObject(forKey: CodingKeys.characters.rawValue) as? [String]
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Episodes", in: context) else {
            throw CoreDataErrors.entityNotFound
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        if let imgUrlString = try? container.decode(String.self, forKey: .img), let imgUrl = URL(string: imgUrlString) {
            self.img = try? Data(contentsOf: imgUrl)
        }
        self.episode = try? container.decode(String.self, forKey: .episode)
        self.characters = try? container.decode([String].self, forKey: .characters)
    }
}
