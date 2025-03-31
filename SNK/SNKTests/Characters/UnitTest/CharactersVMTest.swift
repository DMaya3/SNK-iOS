//
//  CharactersVmTest.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//


import XCTest
import Combine
@testable import SNK


final class CharactersVmTest: XCTestCase {
    var charactersVM: CharactersViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.charactersVM = CharactersViewModel()
    }
    
    func testFillCharacters() {
        // Given
        let mockCharacter = MockCharacters.mockCharacter1 ?? Characters()
        
        if let vm = self.charactersVM {
            // When
            vm.fillCharacters(character: mockCharacter)
            
            // Then
            XCTAssertEqual(vm.characters.count, 1)
            XCTAssertEqual(vm.characters.first?.name, "Eren Jaeger")
        }
    }
    
    func testFilterCharactersByNameAndStatus() {
        // Given
        guard let vm = self.charactersVM else {
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
        guard let vm = self.charactersVM else {
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
        guard let vm = self.charactersVM else {
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
}
