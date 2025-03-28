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
    @Published var episodes: [Episodes] = []
    private var suscription = Set<AnyCancellable>()
    private var coreDataProvider = CoreDataProvider()
    var episodePage: Int = 0
    var episodePages: [Int] = []
    var isLoading: Bool = false
    var rootEpisodes: RootEpisodes = RootEpisodes(entity: NSEntityDescription.entity(forEntityName: "RootEpisodes", in: CoreDataProvider.preview.context) ?? NSEntityDescription(), insertInto: CoreDataProvider.preview.context)
    
    var episodesUseCase: EpisodesUseCase {
        DefaultEpisodesUseCase()
    }
    
    init() {
        Task {
            await self.fetchEpisodes()
        }
    }
    
    func fetchEpisodes() async {
        self.episodePage += 1
        if !self.episodePages.contains(self.episodePage) {
            self.episodePages.append(self.episodePage)
            await self.suscribeEpisodes(page: self.episodePage)
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
    func episodesPublisher(pages: Int) async -> AnyPublisher<RootEpisodes, Error> {
        self.isLoading = true
        return await self.episodesUseCase.fetchDataEpisodes(pages: pages)
    }
    
    func suscribeEpisodes(page: Int) async {
        await episodesPublisher(pages: page)
            .sink { [weak self] completion in
                self?.isLoading = false
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] rootEpisodes in
                self?.isLoading = false
                self?.rootEpisodes = rootEpisodes
                if let results = self?.rootEpisodes.results, !(self?.coreDataProvider.checkIsEpisodeExisting(episodes: results) ?? false) {
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
extension SNKViewModel {
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
