//
//  SNKViewModel.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 21/11/2024.
//

import Combine
import CoreData
import Foundation

class SNKViewModel: ObservableObject {
    @Published var characters: [Characters] = []
    @Published var episodes: [Episodes] = []
    private var suscription = Set<AnyCancellable>()
    private var coreDataProvider = CoreDataProvider()
    private var pagesCharacters = 11
    private var pagesEpisodes = 5
    var root: Root = Root(entity: NSEntityDescription.entity(forEntityName: "Root", in: CoreDataProvider.preview.context) ?? NSEntityDescription(), insertInto: CoreDataProvider.preview.context)
    var rootEpisodes: RootEpisodes = RootEpisodes(entity: NSEntityDescription.entity(forEntityName: "RootEpisodes", in: CoreDataProvider.preview.context) ?? NSEntityDescription(), insertInto: CoreDataProvider.preview.context)
    
    var charactersUseCase: CharactersUseCase {
        DefaultCharatersUseCase()
    }
    
    var episodesUseCase: EpisodesUseCase {
        DefaultEpisodesUseCase()
    }
    
    init() {
        Task {
            await self.fetchCharacters()
            await self.fetchEpisodes()
        }
    }
    
    func fetchCharacters() async {
        if !self.coreDataProvider.checkIsCharacterExisting(characters: self.characters) {
            for page in 1...self.pagesCharacters {
                await self.suscribeCharacters(page: page)
            }
        }
    }
    
    func fetchEpisodes() async {
        if !self.coreDataProvider.checkIsEpisodeExisting(episodes: self.episodes) {
            for page in 1...self.pagesEpisodes {
                await self.suscribeEpisodes(page: page)
            }
        }
    }
}


// MARK: - Handle Errors
private extension SNKViewModel {
    func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
}

// MARK: - Fetch Data
extension SNKViewModel {
    func charactersPublisher(pages: Int) async -> AnyPublisher<Root, Error> {
        return await self.charactersUseCase.fetchDataCharacters(pages: pages)
    }
    
    func suscribeCharacters(page: Int) async {
        await charactersPublisher(pages: page)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] root in
                self?.root = root
                if let results = self?.root.results {
                    for character in results {
                        self?.fillCharacters(character: character)
                    }
                }
            }
            .store(in: &suscription)
    }
    
    func episodesPublisher(pages: Int) async -> AnyPublisher<RootEpisodes, Error> {
        return await self.episodesUseCase.fetchDataEpisodes(pages: pages)
    }
    
    func suscribeEpisodes(page: Int) async {
        await episodesPublisher(pages: page)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] rootEpisodes in
                self?.rootEpisodes = rootEpisodes
                if let results = self?.rootEpisodes.results {
                    for episode in results {
                        self?.fillEpisodes(episode: episode)
                    }
                }
            }
            .store(in: &suscription)
    }
}

// MARK: - Helpers
extension SNKViewModel {
    func fillCharacters(character: Characters) {
        do {
            if let newCharacter = try self.coreDataProvider.saveCharacterEntity(character: character) {
                self.characters.append(newCharacter)
                try CoreDataProvider.preview.saveContext()
                print("Character \(character.name ?? "") saved successfully.")
            }
        } catch let error as NSError {
            print("Error \(error.code): \(error.localizedDescription) - \(error.userInfo)")
        }
    }
    
    func fillEpisodes(episode: Episodes) {
        do {
            let newEpisode = try self.coreDataProvider.saveEpisodeEntity(episode: episode)
            self.episodes.append(newEpisode)
            try CoreDataProvider.preview.saveContext()
            print("Episode \(episode.episode ?? "") saved successfully")
        } catch let error as NSError {
            print("Error \(error.code): \(error.localizedDescription) - \(error.userInfo)")
        }
    }
}
