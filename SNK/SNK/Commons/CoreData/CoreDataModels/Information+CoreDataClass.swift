//
//  Information+CoreDataClass.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//
//

import Foundation
import CoreData

@objc(Information)
public class Information: NSManagedObject, NSSecureCoding, Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case pages
        case next_page
        case prev_page
    }
    
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.count, forKey: CodingKeys.count.rawValue)
        coder.encode(self.pages, forKey: CodingKeys.pages.rawValue)
        coder.encode(self.next_page, forKey: CodingKeys.next_page.rawValue)
        coder.encode(self.prev_page, forKey: CodingKeys.prev_page.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Information", in: context) else {
            return nil
        }
        
        self.init(entity: entity, insertInto: context)
        self.count = coder.decodeInt64(forKey: CodingKeys.count.rawValue)
        self.pages = coder.decodeInt64(forKey: CodingKeys.pages.rawValue)
        self.next_page = coder.decodeObject(forKey: CodingKeys.next_page.rawValue) as? String
        self.prev_page = coder.decodeObject(forKey: CodingKeys.prev_page.rawValue) as? String
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let context = CoreDataProvider.preview.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Information", in: context) else {
            throw CoreDataErrors.entityNotFound
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int64.self, forKey: .count)
        self.pages = try container.decode(Int64.self, forKey: .pages)
        self.next_page = try? container.decode(String.self, forKey: .next_page)
        self.prev_page = try? container.decode(String.self, forKey: .prev_page)
    }
}
