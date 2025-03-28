//
//  CharactersRepository.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 28/3/25.
//

import Foundation
import Combine

protocol CharactersRepository: WebRepository {
    func fetchAllCharactersDataService(pages: Int) async -> AnyPublisher<Root, Error>
}

struct CharactersDataRepository: CharactersRepository {
    var session: URLSession = URLSession.shared
    var baseUrl: String = "https://api.attackontitanapi.com"
    var bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    func fetchAllCharactersDataService(pages: Int) async -> AnyPublisher<Root, any Error> {
        return call(endpoint: API.allCharacters, pages: pages)
    }
}

extension CharactersDataRepository {
    enum API {
        case allCharacters
    }
}

extension CharactersDataRepository.API: APICall {
    var path: String {
        switch self {
        case .allCharacters:
            return "/characters/?page="
        }
    }
    
    var method: String {
        switch self {
        case .allCharacters:
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
