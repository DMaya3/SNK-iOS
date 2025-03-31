//
//  EpisodesVMTest.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 31/3/25.
//

import XCTest
import Combine
@testable import SNK

final class EpisodesVMTest: XCTestCase {
    var episodesVM: EpisodesViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.episodesVM = EpisodesViewModel()
    }
    
    func testFillEpisodes() {
        // Given
        let mockEpisode = MockEpisodes.mockEpisode1 ?? Episodes()
        
        if let vm = self.episodesVM {
            // When
            vm.fillEpisodes(episode: mockEpisode)
            
            // Then
            XCTAssertEqual(vm.episodes.count, 1)
            XCTAssertEqual(vm.episodes.first?.name, "To You, in 2000 Years: The Fall of Shiganshina, Part 1")
            XCTAssertEqual(vm.episodes.first?.episode, "S1E01")
        }
    }
    
    func testFilterEpisodesByNameAndSeasson() {
        // Given
        guard let vm = self.episodesVM else {
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
        guard let vm = self.episodesVM else {
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
        guard let vm = self.episodesVM else {
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
