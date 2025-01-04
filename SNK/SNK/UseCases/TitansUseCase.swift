//
//  TitansUseCase.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 04/01/2025.
//

import Combine

protocol TitansUseCase {
    func fetchDataTitans() async -> AnyPublisher<RootTitan, Error>
}

struct DefaultTitansUseCase: TitansUseCase {
    private let repository = SNKDataRepository()
    
    func fetchDataTitans() async -> AnyPublisher<RootTitan, any Error> {
        return await self.repository.fetchAllTitansDataService()
    }
}
