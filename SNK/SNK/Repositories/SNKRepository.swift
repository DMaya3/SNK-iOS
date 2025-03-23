//
//  SNKRepository.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 21/11/2024.
//

import Foundation
import Combine

protocol SNKRepository: WebRepository {
    func fetchAllCharactersDataService(pages: Int) async -> AnyPublisher<Root, Error>
    func fetchAllEpisodesDataService(pages: Int) async -> AnyPublisher<RootEpisodes, Error>
    func fetchAllTitansDataService() async -> AnyPublisher<RootTitan, Error>
    func fetchCharacterById(id: String) async -> AnyPublisher<Characters, Error>
}

struct SNKDataRepository: SNKRepository {
    var session: URLSession = URLSession.shared
    var baseUrl: String = "https://api.attackontitanapi.com"
    var bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    func fetchAllCharactersDataService(pages: Int) async -> AnyPublisher<Root, any Error> {
        return call(endpoint: API.allCharacters, add: String(pages))
    }
    
    func fetchAllEpisodesDataService(pages: Int) async -> AnyPublisher<RootEpisodes, any Error> {
        return call(endpoint: API.allEpisodes, add: String(pages))
    }
    
    func fetchAllTitansDataService() async -> AnyPublisher<RootTitan, any Error> {
        return call(endpoint: API.allTitans)
    }
    
    func fetchCharacterById(id: String) async -> AnyPublisher<Characters, any Error> {
        return call(endpoint: API.characterById, add: id)
    }
}

extension SNKDataRepository {
    enum API {
        case allCharacters
        case allEpisodes
        case allTitans
        case characterById
    }
}

extension SNKDataRepository.API: APICall {
    var path: String {
        switch self {
        case .allCharacters:
            return "/characters/?page="
        case .allEpisodes:
            return "/episodes/?page="
        case .allTitans:
            return "/titans"
        case .characterById:
            return "/characters/"
        }
    }
    
    var method: String {
        switch self {
        case .allCharacters, .allEpisodes, .allTitans, .characterById:
            return "GET"
        }
    }
    
    var headers: [String : String] {
        return ["Acept" : "application/json"]
    }
    
    func body() throws -> Data? {
        return nil
    }
}
