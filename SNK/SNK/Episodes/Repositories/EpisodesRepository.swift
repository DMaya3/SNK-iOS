//
//  EpisodesRepository.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 30/3/25.
//

import Foundation
import Combine

protocol EpisodesRepository: WebRepository {
    func fetchAllEpisodesDataService(pages: Int) async -> AnyPublisher<RootEpisodes, Error>
}

struct EpisodesDataRepository: EpisodesRepository {
    var session: URLSession = URLSession.shared
    var baseUrl: String = "https://api.attackontitanapi.com"
    var bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    func fetchAllEpisodesDataService(pages: Int) async -> AnyPublisher<RootEpisodes, any Error> {
        return call(endpoint: API.allEpisodes, pages: pages)
    }
}

extension EpisodesDataRepository {
    enum API {
        case allEpisodes
    }
}

extension EpisodesDataRepository.API: APICall {
    var path: String {
        switch self {
        case .allEpisodes:
            return "/episodes/?page="
        }
    }
    
    var method: String {
        switch self {
        case .allEpisodes:
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
