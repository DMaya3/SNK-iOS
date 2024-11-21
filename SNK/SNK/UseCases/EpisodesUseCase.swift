//
//  EpisodesUseCase.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 21/11/2024.
//

import Combine

protocol EpisodesUseCase {
    func fetchDataEpisodes(pages: Int) async -> AnyPublisher<RootEpisodes, Error>
}

struct DefaultEpisodesUseCase: EpisodesUseCase {
    private let repository = SNKDataRepository()
    
    func fetchDataEpisodes(pages: Int) async -> AnyPublisher<RootEpisodes, any Error> {
        return await self.repository.fetchAllEpisodesDataService(pages: pages)
    }
}
