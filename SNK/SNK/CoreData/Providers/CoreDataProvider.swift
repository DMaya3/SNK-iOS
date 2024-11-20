//
//  CoreDataProvider.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//

import Foundation
import CoreData

class CoreDataProvider {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataProvider()
    private var savedCharactersIDs: Set<Int64> = []
    
    var context: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }
    
    static var preview: CoreDataProvider = {
        let provider = CoreDataProvider(inMemory: true)
        let context = provider.context
        var characters: [Characters] = []
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        return provider
    }()
    
    init(inMemory: Bool = false) {
        self.persistentContainer = NSPersistentContainer(name: "ShingekiDM")
        
        if inMemory {
            self.persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        self.persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        do {
            let fetchRequest: NSFetchRequest<Characters> = Characters.fetchRequest()
            fetchRequest.fetchLimit = 1
            let testFetch = try context.fetch(fetchRequest)
            print("Test fetch succeeded. Characters in database: \(testFetch.count)")
        } catch {
            print("Test fetch failed: \(error.localizedDescription)")
        }
    }
    
    func saveContext() throws {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch let error as NSError {
                throw CoreDataErrors.errorSavingContext("Error \(error.code): \(error.localizedDescription) - \(error.userInfo)")
            }
        }
    }
    
    func saveCharacterEntity(character: Characters) throws -> Characters? {
        guard let entity = NSEntityDescription.entity(forEntityName: "Characters", in: CoreDataProvider.shared.context) else {
            throw CoreDataErrors.entityNotFound
        }
        let characterEntity = Characters(entity: entity, insertInto: CoreDataProvider.shared.context)
        characterEntity.id = character.id
        characterEntity.name = character.name
        characterEntity.img = character.img
        characterEntity.alias = character.alias
        characterEntity.species = character.species
        characterEntity.gender = character.gender
        characterEntity.age = character.age
        characterEntity.height = character.height
        characterEntity.relatives = character.relatives
        characterEntity.birthplace = character.birthplace
        characterEntity.residence = character.residence
        characterEntity.status = character.status
        characterEntity.occupation = character.occupation
        characterEntity.groups = character.groups
        characterEntity.roles = character.roles
        characterEntity.episodes = character.episodes
        
        self.savedCharactersIDs.insert(character.id)
        try self.saveContext()
        return characterEntity
    }
    
    func saveEpisodeEntity(episode: Episodes) throws -> Episodes {
        let context = CoreDataProvider.shared.context
        guard let entity = NSEntityDescription.entity(forEntityName: "Episodes", in: context) else {
            throw CoreDataErrors.entityNotFound
        }
        let episodeEntity = Episodes(entity: entity, insertInto: context)
        episodeEntity.id = episode.id
        episodeEntity.name = episode.name
        episodeEntity.img = episode.img
        episodeEntity.episode = episode.episode
        episodeEntity.characters = episode.characters
        return episodeEntity
    }
}

// MARK: - FetchData from CoreData and save to CoreData
extension CoreDataProvider {
    func checkIsCharacterExisting(characters: [Characters]) -> Bool {
        var isExisting = false
        for character in characters {
            do {
                let fetchRequest: NSFetchRequest<Characters> = Characters.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: character.id))
                
                let existingCharacters = try CoreDataProvider.shared.context.fetch(fetchRequest)
                
                if !existingCharacters.isEmpty {
                    print("Character with id \(character.id) already exists.")
                    isExisting = true
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                isExisting = false
            }
        }
        return isExisting
    }
    
    func checkIsEpisodeExisting(episodes: [Episodes]) -> Bool {
        var isExisting = false
            episodes.forEach { episode in
                do {
                    let fetchRequest: NSFetchRequest<Episodes> = Episodes.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: episode.id))
                    
                    let exisitngEpisodes = try CoreDataProvider.shared.context.fetch(fetchRequest)
                    
                    if !exisitngEpisodes.isEmpty {
                        isExisting = true
                        print("Episode with id \(episode.id) already exists.")
                    } else {
                        isExisting = false
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        return isExisting
    }
}
