//
//  WebRepository.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 21/11/2024.
//

import Foundation
import Combine

protocol WebRepository {
    var session: URLSession { get }
    var baseUrl: String { get }
    var bgQueue: DispatchQueue { get }
}

extension WebRepository {
    func call<T>(endpoint: APICall, httpCodes: HTTPCodes = .success, pages: Int) -> AnyPublisher<T, Error> where T: Decodable {
        do {
            let request = try endpoint.urlRequest(baseUrl: self.baseUrl, add: String(pages))
            return self.session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes)
        } catch {
            return Fail<T, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<T>(httpCodes: HTTPCodes) -> AnyPublisher<T, Error> where T: Decodable {
        return tryMap {
            assert(!Thread.isMainThread)
            
            guard let code = ($1 as? HTTPURLResponse)?.statusCode else {
                throw APIError.unexpectedResponse
            }
            
            guard httpCodes.contains(code) else {
                throw APIError.httpCode(code)
            }
            
            return $0
        }
        .extractUnderlyingError()
        .decode(type: T.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .mapError { error in
            if let myError = error as? APIError {
                switch myError {
                case .invalidUrl:
                    return APIError.invalidUrl
                case .httpCode(let code):
                    return APIError.httpCode(code)
                case .unexpectedResponse:
                    return APIError.unexpectedResponse
                }
            } else {
                return error
            }
        }
        .eraseToAnyPublisher()
    }
}
