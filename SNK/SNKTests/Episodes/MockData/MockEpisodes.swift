//
//  MockEpisodes.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//


import CoreData
@testable import SNK

struct MockEpisodes {
    
    static let context: NSManagedObjectContext = CoreDataProvider().context
    
    static var mockEpisode1: Episodes? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Episodes", in: self.context) else {
            return nil
        }
        
        let episode = Episodes(entity: entity, insertInto: self.context)
        episode.id = 1
        episode.name = "To You, in 2000 Years: The Fall of Shiganshina, Part 1"
        episode.img = nil
        episode.episode = "S1E01"
        episode.characters = ["Eren Jaeger", "Armin Alert", "Mikasa Ackerman"]
        
        return episode
    }
    
    static var mockEpisode2: Episodes? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Episodes", in: self.context) else {
            return nil
        }
        
        let episode = Episodes(entity: entity, insertInto: self.context)
        episode.id = 2
        episode.name = "That Day: The Fall of Shiganshina, Part 2"
        episode.img = nil
        episode.episode = "S1E02"
        episode.characters = ["Eren Jaeger", "Armin Alert", "Mikasa Ackerman"]
        
        return episode
    }
    
    static var mockEpisode3: Episodes? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Episodes", in: self.context) else {
            return nil
        }
        
        let episode = Episodes(entity: entity, insertInto: self.context)
        episode.id = 3
        episode.name = "A Dim Light Amid Despair: Humanity´s Comeback, Part 1"
        episode.img = nil
        episode.episode = "S1E03"
        episode.characters = ["Eren Jaeger", "Armin Alert", "Mikasa Ackerman"]
        
        return episode
    }
    
    static var mockEpisode4: Episodes? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Episodes", in: self.context) else {
            return nil
        }
        
        let episode = Episodes(entity: entity, insertInto: self.context)
        episode.id = 4
        episode.name = "The Night of the Closing Ceremony: Humanity´s Comeback, Part 2"
        episode.img = nil
        episode.episode = "S1E01"
        episode.characters = ["Eren Jaeger", "Armin Alert", "Mikasa Ackerman"]
        
        return episode
    }
    
    static var episodesList: [Episodes] = [mockEpisode1,
                                           mockEpisode2,
                                           mockEpisode3,
                                           mockEpisode4].compactMap { $0 }
}
