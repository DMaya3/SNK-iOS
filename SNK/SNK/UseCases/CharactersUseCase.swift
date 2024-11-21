//
//  CharactersUseCase.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 21/11/2024.
//

import Combine

protocol CharactersUseCase {
    func fetchDataCharacters(pages: Int) async -> AnyPublisher<Root, Error>
}

struct DefaultCharatersUseCase: CharactersUseCase {
    private let repository = SNKDataRepository()
    
    func fetchDataCharacters(pages: Int) async -> AnyPublisher<Root, any Error> {
        return await self.repository.fetchAllCharactersDataService(pages: pages)
    }
}
