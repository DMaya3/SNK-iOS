//
//  EpisodeDetailView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 24/11/2024.
//

import SwiftUI

struct EpisodeDetailView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var isZoomed: Bool = false
    private var episode: Episodes
    private var episodes: [Episodes]
    private var characters: [Characters]
    
    init(episode: Episodes, episodes: [Episodes], characters: [Characters]) {
        self.episode = episode
        self.episodes = episodes
        self.characters = characters
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ImageView(isZoomed: $isZoomed,
                          imageData: self.episode.img,
                          imageWidth: 200,
                          imageHeight: 200)
                
                if let episode = self.episode.episode {
                    let seasonString = String(episode.prefix(2))
                    let episodeString = episode.split(separator: "E")
                    
                    let componentsSeason = seasonString.split(separator: "S")
                    if let numberSeason = componentsSeason.last {
                        let localizedText = self.localization.edv_season_title(number: String(numberSeason))
                        self.textSeasonEpisode(localizedText)
                    }
                    
                    if let numberEpisode = episodeString.last, let name = self.episode.name {
                        let localizedText = self.localization.edv_episode_title(number: String(numberEpisode), title: name)
                        self.textSeasonEpisode(localizedText)
                    }
                }
                
                if let characters = self.episode.characters {
                    Text(self.localization.title_characters)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(self.colorByColorScheme)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    if let newCharacters = self.helpers.getArrayObjectById(stringArray: characters, objectArray: self.characters) as? [Characters] {
                        ForEach(newCharacters, id: \.self) { character in
                            NavigationLink {
                                CharacterDetailView(character: character, characters: self.characters, episodes: self.episodes)
                            } label: {
                                HStack {
                                    ImageView(imageData: character.img,
                                              imageWidth: 50,
                                              imageHeight: 50,
                                              shadowRadius: 5)
                                    
                                    if let name = character.name {
                                        Text(name)
                                            .font(.body.bold())
                                            .foregroundStyle(self.colorByColorScheme)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width - 20,
                                       height: 70,
                                       alignment: .leading)
                                .cornerRadius(20)
                            }
                        }
                    }
                }
            }
        }
        .background(LinearGradient(colors: [Color(.backgroundOne), Color(.backgroundTwo)],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
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

extension EpisodeDetailView {
    private var localization: Localization {
        DefaultLocalization()
    }
    
    private var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    var helpers: Helpers {
        DefaultHelpers()
    }
    
    func textSeasonEpisode(_ localizedText: String) -> some View {
        return Text(localizedText)
            .font(.body.bold())
            .foregroundStyle(self.colorByColorScheme)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
}
