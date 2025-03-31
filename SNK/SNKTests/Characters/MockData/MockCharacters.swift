//
//  MockCharacters.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//


import CoreData
@testable import SNK

struct MockCharacters {
    
    static let context: NSManagedObjectContext = CoreDataProvider().context
    
    static var mockCharacter1: Characters? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Characters", in: context) else {
            return nil
        }
        
        let character = Characters(entity: entity, insertInto: context)
        character.id = 1
        character.name = "Eren Jaeger"
        character.img = nil
        character.alias = ["Eren", "Attack Titan"]
        character.species = ["Human", "Titan"]
        character.gender = "Male"
        character.age = 19
        character.height = "183 cm"
        character.relatives = []
        character.birthplace = "Shiganshina District"
        character.residence = "Paradise Island"
        character.status = "Alive"
        character.occupation = "Soldier"
        character.groups = []
        character.roles = ["Protagonist"]
        character.episodes = ["To You, in 2000 years", "The Attack Titan", "From you, 2000 years ago"]
        
        return character
    }
    
    static var mockCharacter2: Characters? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Characters", in: context) else {
            return nil
        }
        
        let character = Characters(entity: entity, insertInto: context)
        character.id = 2
        character.name = "Mikasa Ackerman"
        character.img = nil
        character.alias = ["Mikasa"]
        character.species = ["Human"]
        character.gender = "Female"
        character.age = 19
        character.height = "183 cm"
        character.relatives = []
        character.birthplace = "Shiganshina District"
        character.residence = "Paradise Island"
        character.status = "Alive"
        character.occupation = "Soldier"
        character.groups = []
        character.roles = ["Protagonist"]
        character.episodes = ["To You, in 2000 years", "The Attack Titan", "From you, 2000 years ago"]
        
        return character
    }
    
    static var mockCharacter3: Characters? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Characters", in: context) else {
            return nil
        }
        
        let character = Characters(entity: entity, insertInto: context)
        character.id = 3
        character.name = "Armin Alert"
        character.img = nil
        character.alias = ["Armin", "Colossal Titan"]
        character.species = ["Human", "Titan"]
        character.gender = "Male"
        character.age = 19
        character.height = "179 cm"
        character.relatives = []
        character.birthplace = "Shiganshina District"
        character.residence = "Paradise Island"
        character.status = "Alive"
        character.occupation = "Commander Squad"
        character.groups = []
        character.roles = ["Protagonist"]
        character.episodes = ["To You, in 2000 years", "The Attack Titan", "From you, 2000 years ago"]
        
        return character
    }
    
    static var mockCharacter4: Characters? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Characters", in: context) else {
            return nil
        }
        
        let character = Characters(entity: entity, insertInto: context)
        character.id = 4
        character.name = "Levi Ackerman"
        character.img = nil
        character.alias = ["Levi", "Captain"]
        character.species = ["Human"]
        character.gender = "Male"
        character.age = 21
        character.height = "177 cm"
        character.relatives = []
        character.birthplace = "Unknown"
        character.residence = "Paradise Island"
        character.status = "Alive"
        character.occupation = "Captain"
        character.groups = []
        character.roles = ["Protagonist"]
        character.episodes = ["To You, in 2000 years", "The Attack Titan", "From you, 2000 years ago"]
        
        return character
    }
    
    static var charactersList: [Characters] = [mockCharacter1,
                                               mockCharacter2,
                                               mockCharacter3,
                                               mockCharacter4].compactMap { $0 }
}
