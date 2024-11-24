//
//  CharacterDetailView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 24/11/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var isZoomed: Bool = false
    private var character: Characters
    private var characters: [Characters]
    private var episodes: [Episodes]
    
    init(character: Characters, characters: [Characters], episodes: [Episodes]) {
        self.character = character
        self.characters = characters
        self.episodes = episodes
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ImageView(isZoomed: $isZoomed,
                          imageData: self.character.img,
                          imageWidth: 200,
                          imageHeight: 200)
                
                if let name = self.character.name {
                    let string = self.character.age > 0 ? self.localization.cdv_name_and_age(name: name, age: String(self.character.age)) : name
                    Text(string)
                        .font(.body.bold())
                        .foregroundStyle(self.colorByColorScheme)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                
                if let alias = self.character.alias, !alias.isEmpty {
                    if alias.count == 1 {
                        if let subname = alias.first {
                            HStack {
                                Text(self.localization.cdv_alias)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(self.colorByColorScheme)
                                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 3, trailing: 0))
                                Text(subname)
                                    .font(.body)
                                    .foregroundStyle(self.colorByColorScheme)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    } else {
                        SectionView(nameSection: self.localization.cdv_alias, stringArray: alias)
                    }
                }
                
                if let residence = self.character.residence, let birthplace = self.character.birthplace {
                    Text(self.localization.cdv_residence(birthplace: birthplace, residence: residence))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                
                if let species = self.character.species, !species.isEmpty {
                    let updatedSpecies = self.translateSpecies(species: species)
                    SectionView(nameSection: self.localization.cdv_section_species, stringArray: updatedSpecies)
                }
                
                if let relatives = self.character.relatives, !relatives.isEmpty {
                    ForEach(relatives, id: \.self) { relative in
                        if let family = relative.family, !family.isEmpty, let members = relative.members, !members.isEmpty {
                            SectionImageCarouselView(nameSection: self.localization.cdv_section_family(family: family), members: members, characters: self.characters)
                        }
                    }
                }
                
                if let roles = self.character.roles, !roles.isEmpty {
                    SectionView(nameSection: self.localization.cdv_section_roles, stringArray: roles)
                }
                
                if let urlEpisodes = self.character.episodes, !urlEpisodes.isEmpty {
                    SectionImageCarouselView(nameSection: self.localization.cdv_section_episodes, urlEpisodes: urlEpisodes, episodes: self.episodes)
                }
            }
        }
        .background(LinearGradient(colors: [Color(.backgroundOne), Color(.backgroundTwo)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.dismiss.callAsFunction()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(self.colorByColorScheme)
                        .font(.title3)
                }
                .padding()
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    HomeView()
                } label: {
                    Image(systemName: "house.fill")
                        .foregroundStyle(self.colorByColorScheme)
                        .font(.title3)
                }
                .padding()
            }
        }
    }
}

extension CharacterDetailView {
    private var localization: Localization {
        DefaultLocalization()
    }
    
    private var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    func translateSpecies(species: [String]) -> [String] {
        var updatedSpecies: [String] = []
        species.forEach { specie in
            let newSpecie = self.localization.cdv_species(specie: specie)
            updatedSpecies.append(newSpecie)
        }
        return updatedSpecies
    }
}
