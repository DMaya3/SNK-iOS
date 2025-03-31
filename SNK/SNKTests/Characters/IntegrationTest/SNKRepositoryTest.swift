//
//  SNKRepositoryTest.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//


import XCTest
@testable import SNK

final class SNKRepositoryTest: XCTestCase {
    
    func testCallAPISuccess() throws {
        // Given
        let request = self.getRequest()
        
        // When
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let _ = data, error == nil, let result = response as? HTTPURLResponse else {
                print("Connection error: \(String(describing: error))")
                return
            }
        
        // Then
            do {
                XCTAssertTrue(result.statusCode == 200)
            }
        }.resume()
    }
    
    func testCallAPICharactersAndReturnCharactersSuccess() throws {
        // Given
        let request = self.getRequest(for: "characters")
        
        // When
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let _ = response as? HTTPURLResponse else {
                XCTFail("Connection error: \(String(describing: error))")
                return
            }
            
        // Then
            do {
                let characters = try JSONDecoder().decode(Root.self, from: data)
                XCTAssertNotNil(characters.results)
            } catch {
                print("Error: \(error)")
            }
        }.resume()
    }
    
    func testCallAPICharactersButNotReturnCharacters() throws {
        // Given
        let request = self.getRequest(for: "characters")
        
        // When
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                XCTFail("Connection error: \(String(describing: error))")
                return
            }
            
        // Then
            do {
                let characters = try JSONDecoder().decode(Root.self, from: data)
                XCTAssertTrue(((characters.results?.isEmpty) != nil))
            } catch {
                print("Error: \(error)")
                XCTAssertNotNil(data)
            }
        }.resume()
    }
    
    func testCallAPIEpisodesAndReturnCEpisodesSuccess() throws {
        // Given
        let request = self.getRequest(for: "episodes")
        
        // When
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let _ = response as? HTTPURLResponse else {
                XCTFail("Connection error: \(String(describing: error))")
                return
            }
            
        // Then
            do {
                let episodes = try JSONDecoder().decode(RootEpisodes.self, from: data)
                XCTAssertNotNil(episodes.results)
            } catch {
                print("Error: \(error)")
            }
        }.resume()
    }
    
    func testCallAPIEpisodesButNotReturnEpisodes() throws {
        // Given
        let request = self.getRequest(for: "episodes")
        
        // When
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                XCTFail("Connection error: \(String(describing: error))")
                return
            }
            
        // Then
            do {
                let episodes = try JSONDecoder().decode(RootEpisodes.self, from: data)
                XCTAssertTrue(((episodes.results?.isEmpty) != nil))
            } catch {
                print("Error: \(error)")
                XCTAssertNotNil(data)
            }
        }.resume()
    }
}

private extension SNKRepositoryTest {
    func getRequest(for parameter: String = "") -> URLRequest {
        let stringUrl = "https://api.attackontitanapi.com/\(parameter)"
        let url = URL(string: stringUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json: charset=utf8", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
