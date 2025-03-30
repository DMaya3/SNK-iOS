//
//  CharactersViewModel.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 28/3/25.
//

import Combine
import CoreData
import Foundation

class CharactersViewModel: ObservableObject {
    @Published var characters: [Characters] = []
    private var suscription = Set<AnyCancellable>()
    private var coreDataProvider = CoreDataProvider()
    private var page: Int = 0
    private var pages: [Int] = []
    
    var useCase: CharactersUseCase {
        DefaultCharatersUseCase()
    }
    
    init() {
        Task {
            await self.fetchCharacters()
        }
    }
    
    func fetchCharacters() async {
        self.page += 1
        if !self.pages.contains(self.page) {
            self.pages.append(self.page)
            await self.suscribeCharacters(page: self.page)
        }
    }
    
    
}

// MARK: - Handle Errors
private extension CharactersViewModel {
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
extension CharactersViewModel {
    func charactersPublisher(pages: Int) async -> AnyPublisher<Root, Error> {
        return await self.useCase.fetchDataCharacters(pages: pages)
    }
    
    func suscribeCharacters(page: Int) async {
        await charactersPublisher(pages: page)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] root in
               // self?.root = root
                if let results = root.results, !(self?.coreDataProvider.checkIsCharacterExisting(characters: results) ?? false) {
                    for character in results {
                        self?.fillCharacters(character: character)
                    }
                }
            }
            .store(in: &suscription)
    }
}

// MARK: - Helpers
extension CharactersViewModel {
    func fillCharacters(character: Characters) {
        do {
            if let newCharacter = try self.coreDataProvider.saveCharacterEntity(character: character) {
                self.characters.append(newCharacter)
                print("Character \(character.name ?? "") saved successfully.")
            }
        } catch let error as NSError {
            print("Error \(error.code): \(error.localizedDescription) - \(error.userInfo)")
        }
    }
}

// MARK: - Filters
extension CharactersViewModel {
    func filterCharacters(filterName: String = "", filterStatus: Status = .none) -> [Characters] {
        let filteredCharacters = self.characters.filter { character in
            guard let name = character.name, let status = character.status else {
                return false
            }
            if !filterName.isEmpty && filterStatus != .none {
                return name.lowercased().contains(filterName.lowercased()) && status.contains(filterStatus.rawValue)
            } else if !filterName.isEmpty {
                return name.lowercased().contains(filterName.lowercased())
            } else if filterStatus != .none {
                return status.contains(filterStatus.rawValue)
            } else {
                return false
            }
        }
        return filteredCharacters
    }
}
