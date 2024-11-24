//
//  SectionImageCarouselView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 24/11/2024.
//


import SwiftUI

struct SectionImageCarouselView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var currentIndex: Int = 0
    @State private var unnamedMembers: [String] = []
    private var nameSection: String
    private var members: [String]
    private var urlEpisodes: [String]
    private var characters: [Characters]
    private var episodes: [Episodes]
    
    init(nameSection: String,
         members: [String] = [],
         urlEpisodes: [String] = [],
         characters: [Characters] = [],
         episodes: [Episodes] = []) {
        self.nameSection = nameSection
        self.members = members
        self.urlEpisodes = urlEpisodes
        self.characters = characters
        self.episodes = episodes
    }
    
    var body: some View {
        if !self.newArray.isEmpty {
            Text(self.nameSection)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(self.colorByColorScheme)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
            TabView(selection: $currentIndex) {
                ForEach(self.newArray.indices, id: \.self) { index in
                    NavigationLink {
                        if let charactersArray = self.newArray as? [Characters] {
                            CharacterDetailView(character: charactersArray[index], characters: self.characters, episodes: self.episodes)
                        } else if let episodesArray = self.newArray as? [Episodes] {
                            EpisodeDetailView(episode: episodesArray[index], episodes: self.episodes, characters: self.characters)
                        }
                    } label: {
                        if let image = self.newArray[index].img, let name = self.newArray[index].name {
                            VStack {
                                Image(uiImage: UIImage(data: image) ?? UIImage())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: !self.membersFamily.isEmpty || !self.arrayEpisodes.isEmpty ? 200 : 0)
                                    .cornerRadius(20)
                                    .shadow(color: self.colorByColorScheme, radius: 10)
                                
                                Text(name)
                                    .font(.body.bold())
                                    .foregroundStyle(self.colorByColorScheme)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.all, 15)
                            }
                        } else {
                            Text("No data")
                                .font(.body.bold())
                                .foregroundStyle(self.colorByColorScheme)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, idealHeight: !self.membersFamily.isEmpty || !self.arrayEpisodes.isEmpty ? 300 : 0, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
    }
}

extension SectionImageCarouselView {
    private var localization: Localization {
        DefaultLocalization()
    }
    
    var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    var helpers: Helpers {
        DefaultHelpers()
    }
    
    var membersFamily: [ArrayConvertible] {
        self.helpers.getArrayObjectById(stringArray: self.members, objectArray: self.characters)
    }
    
    var arrayEpisodes: [ArrayConvertible] {
        self.helpers.getArrayObjectById(stringArray: self.urlEpisodes, objectArray: self.episodes)
    }
    
    var newArray: [ArrayConvertible] {
        return !self.membersFamily.isEmpty ? self.membersFamily : self.arrayEpisodes
    }
}
