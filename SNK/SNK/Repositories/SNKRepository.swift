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
}

struct SNKDataRepository: SNKRepository {
    var session: URLSession = URLSession.shared
    var baseUrl: String = "https://api.attackontitanapi.com"
    var bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    func fetchAllCharactersDataService(pages: Int) async -> AnyPublisher<Root, any Error> {
        return call(endpoint: API.allCharacters, pages: pages)
    }
    
    func fetchAllEpisodesDataService(pages: Int) async -> AnyPublisher<RootEpisodes, any Error> {
        return call(endpoint: API.allEpisodes, pages: pages)
    }
}

extension SNKDataRepository {
    enum API {
        case allCharacters
        case allEpisodes
    }
}

extension SNKDataRepository.API: APICall {
    var path: String {
        switch self {
        case .allCharacters:
            return "/characters/?page="
        case .allEpisodes:
            return "/episodes/?page="
        }
    }
    
    var method: String {
        switch self {
        case .allCharacters, .allEpisodes:
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
