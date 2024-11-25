//
//  ViewModelTests.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//


import XCTest
import Combine
@testable import SNK


final class ViewModelTests: XCTestCase {
    var viewModel: SNKViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.viewModel = SNKViewModel()
    }
    
    func testFillCharacters() {
        // Given
        let mockCharacter = MockCharacters.mockCharacter1 ?? Characters()
        
        if let vm = self.viewModel {
            // When
            vm.fillCharacters(character: mockCharacter)
            
            // Then
            XCTAssertEqual(vm.characters.count, 1)
            XCTAssertEqual(vm.characters.first?.name, "Eren Jaeger")
        }
    }
    
    func testSuscribeCharacters() async {
        // Given
        let expectation = XCTestExpectation(description: "Root should be received")
        
        if let vm = self.viewModel {
        // When
            await vm.suscribeCharacters(page: 1)
            
        // Then
            XCTAssertNotNil(vm.root)
            if let results = vm.root.results {
                XCTAssertFalse(results.isEmpty)
            }
            if let info = vm.root.info {
                XCTAssertEqual(info.pages, 11)
                XCTAssertEqual(info.count, 201)
            }
            expectation.fulfill()
            await fulfillment(of: [expectation], timeout: 1.0)
        }
    }
    
    func testFillEpisodes() {
        // Given
        let mockEpisode = MockEpisodes.mockEpisode1 ?? Episodes()
        
        if let vm = self.viewModel {
        // When
            vm.fillEpisodes(episode: mockEpisode)
            
        // Then
            XCTAssertEqual(vm.episodes.count, 1)
            XCTAssertEqual(vm.episodes.first?.name, "To You, in 2000 Years: The Fall of Shiganshina, Part 1")
            XCTAssertEqual(vm.episodes.first?.episode, "S1E01")
        }
    }
    
    func testSuscribeEpisodes() async {
        // Given
        let expectation = XCTestExpectation(description: "RootEpisodes should be received")
        
        if let vm = self.viewModel {
        // When
            await vm.suscribeEpisodes(page: 1)
            
        // Then
            XCTAssertNotNil(vm.rootEpisodes)
            if let results = vm.rootEpisodes.results {
                XCTAssertFalse(results.isEmpty)
            }
            if let info = vm.rootEpisodes.info {
                XCTAssertEqual(info.pages, 5)
                XCTAssertEqual(info.count, 88)
            }
            expectation.fulfill()
            await fulfillment(of: [expectation], timeout: 1.0)
        }
    }
    
    func testFilterCharactersByNameAndStatus() {
        // Given
        guard let vm = self.viewModel else {
            XCTFail("ViewModel is nil")
            return
        }
        
        // When
        vm.characters = MockCharacters.charactersList
        let filtered = vm.filterCharacters(filterName: "Armin", filterStatus: .alive)
        
        if let name = filtered[0].name, let status = filtered[0].status {
            // Then
            XCTAssertEqual(filtered.count, 1)
            XCTAssertTrue(name.lowercased().contains("Armin".lowercased()))
            XCTAssertEqual(status, "Alive")
        }
    }
    
    func testFilterCharactersByName() {
        // Given
        guard let vm = self.viewModel else {
            XCTFail("ViewModel is nil")
            return
        }
        
        // When
        vm.characters = MockCharacters.charactersList
        let filtered = vm.filterCharacters(filterName: "Mikasa")
        
        if let name = filtered[0].name {
        // Then
            XCTAssertEqual(filtered.count, 1)
            XCTAssertTrue(name.lowercased().contains("Mikasa".lowercased()))
        }
    }
    
    func testFilterCharactersByStatus() {
        // Given
        guard let vm = self.viewModel else {
            XCTFail("ViewModel is nil")
            return
        }
        
        // When
        vm.characters = MockCharacters.charactersList
        let filtered = vm.filterCharacters(filterStatus: .alive)

        if let status = filtered[0].status {
        // Then
            XCTAssertEqual(filtered.count, 4)
            XCTAssertEqual(status, "Alive")
        }
    }
    
    func testFilterEpisodesByNameAndSeasson() {
        // Given
        guard let vm = self.viewModel else {
            XCTFail("ViewModel is nil")
            return
        }
        
        // When
        vm.episodes = MockEpisodes.episodesList
        let filtered = vm.filterEpisodes(filterName: "To You", filterSeason: .sOne)
        
        if let name = filtered[0].name, let episode = filtered[0].episode {
        // Then
            XCTAssertEqual(filtered.count, 1)
            XCTAssertTrue(name.lowercased().contains("To You".lowercased()))
            XCTAssertTrue(episode.starts(with: "S1"))
        }
    }
    
    func testFilterEpisodesByName() {
        // Given
        guard let vm = self.viewModel else {
            XCTFail("ViewModel is nil")
            return
        }
        
        // When
        vm.episodes = MockEpisodes.episodesList
        let filtered = vm.filterEpisodes(filterName: "Humanity´s Comeback")
        
        if let name = filtered[0].name {
            XCTAssertEqual(filtered.count, 2)
            XCTAssertTrue(name.lowercased().contains("Humanity´s Comeback".lowercased()))
        }
    }
    
    func testFilterEpisodesBySeasson() {
        // Given
        guard let vm = self.viewModel else {
            XCTFail("ViewModel is nil")
            return
        }
        
        // When
        vm.episodes = MockEpisodes.episodesList
        let filtered = vm.filterEpisodes(filterSeason: .sOne)
        
        if let episode = filtered[0].episode {
            XCTAssertEqual(filtered.count, 4)
            XCTAssertTrue(episode.starts(with: "S1"))
        }
    }
}
