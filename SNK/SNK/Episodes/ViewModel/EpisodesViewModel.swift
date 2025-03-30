//
//  EpisodesViewModel.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 30/3/25.
//

import Combine
import CoreData
import Foundation

class EpisodesViewModel: ObservableObject {
    @Published var episodes: [Episodes] = []
    private var suscription = Set<AnyCancellable>()
    private var coreDataProvider = CoreDataProvider()
    var page: Int = 0
    var pages: [Int] = []
    
    var episodesUseCase: EpisodesUseCase {
        DefaultEpisodesUseCase()
    }
}

// MARK: - Handle Errors
private extension EpisodesViewModel {
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
private extension EpisodesViewModel {
    func episodesPublisher(pages: Int) async -> AnyPublisher<RootEpisodes, Error> {
        return await self.episodesUseCase.fetchDataEpisodes(pages: pages)
    }
    
    func suscribeEpisodes(pages: Int) async {
        await episodesPublisher(pages: pages)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] rootEpisodes in
                if let results = rootEpisodes.results, !(self?.coreDataProvider.checkIsEpisodeExisting(episodes: results) ?? false) {
                    for episode in results {
                        self?.fillEpisodes(episode: episode)
                    }
                }
            }
            .store(in: &suscription)
    }
}

// MARK: - Helpers
private extension EpisodesViewModel {
    func fillEpisodes(episode: Episodes) {
        do {
            let newEpisode = try self.coreDataProvider.saveEpisodeEntity(episode: episode)
            self.episodes.append(newEpisode)
            print("Episode \(episode.episode ?? "") saved successfully")
        } catch let error as NSError {
            print("Error \(error.code): \(error.localizedDescription) - \(error.userInfo)")
        }
    }
}

// MARK: - Filters
extension EpisodesViewModel {
    func filterEpisodes(filterName: String = "", filterSeason: Seasons = .none) -> [Episodes] {
        var filterSeasonString: String {
            switch filterSeason {
            case .sOne:
                return "S1"
            case .sTwo:
                return "S2"
            case .sThree:
                return "S3"
            case .sFour:
                return "S4"
            case .none:
                return ""
            }
        }
        
        let filteredEpisodes = self.episodes.filter { episode in
            guard let name = episode.name, let numberEpisode = episode.episode else {
                return false
            }
            if !filterName.isEmpty && filterSeason != .none {
                return name.lowercased().contains(filterName.lowercased()) && numberEpisode.starts(with: filterSeasonString)
            } else if !filterName.isEmpty {
                return name.lowercased().contains(filterName.lowercased())
            } else if filterSeason != .none {
                return numberEpisode.starts(with: filterSeasonString)
            } else {
                return false
            }
        }
        return filteredEpisodes
    }
}
