//
//  EpisodesListView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 24/11/2024.
//

import SwiftUI

struct EpisodesListView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: SNKViewModel
    @State private var isMenuOpen: Bool = false
    @State private var isZoomed: Bool = false
    @State private var isPresented: Bool = false
    @State private var isFiltered: Bool = false
    @State private var name: String = ""
    @State private var seasons: Seasons = .none
    @State private var episodes: [Episodes]
    private var characters: [Characters]
    private var originalEpisodes: [Episodes]
    
    init(episodes: [Episodes], characters: [Characters]) {
        self.episodes = episodes
        self.characters = characters
        self.originalEpisodes = episodes
    }
    
    var body: some View {
        ZStack {
            if self.episodes.isEmpty {
                EmptyListView(isFiltered: $isFiltered)
            } else {
                VStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(self.episodes.sorted { $0.episode ?? "" < $1.episode ?? "" }, id: \.self) { item in
                                NavigationLink {
                                    EpisodeDetailView(episode: item, episodes: self.episodes, characters: self.characters)
                                } label: {
                                    VStack {
                                        HStack {
                                            ImageView(imageData: item.img,
                                                      imageWidth: 125,
                                                      imageHeight: 125)
                                            VStack {
                                                if let name = item.name, name != "" {
                                                    Text(self.localization.name_charlist_view(name: name))
                                                        .multilineTextAlignment(.leading)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .font(.subheadline)
                                                        .fontWeight(.semibold)
                                                        .foregroundStyle(self.colorByColorScheme)
                                                        .padding(.trailing, 10)
                                                }
                                                if let episode = item.episode, episode != "" {
                                                    Text(episode)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .font(.subheadline)
                                                        .fontWeight(.semibold)
                                                        .foregroundStyle(self.colorByColorScheme)
                                                }
                                            }
                                        }
                                        .padding()
                                    }
                                }
                            }
                        }
                    }
                }
                .disabled(self.isMenuOpen)
                .blur(radius: self.isMenuOpen ? 3 : 0)
                .background(LinearGradient(colors: [Color(.backgroundOne), Color(.backgroundTwo)],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
                .sheet(isPresented: $isPresented, content: {
                    FilterView(isCharacter: false) { name, _, seasons in
                        self.name = name
                        self.seasons = seasons
                        self.isFiltered = name.isEmpty && seasons == .none ? false : true
                        self.episodes = self.viewModel.filterEpisodes(filterName: self.name, filterSeason: self.seasons)
                    }
                })
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            self.dismiss.callAsFunction()
                        }) {
                            Image(systemName: "chevron.backward")
                                .foregroundStyle(self.colorByColorScheme)
                                .font(.title3)
                        }
                        .padding()
                    }
                    ToolbarItem(placement: .principal) {
                        Text(self.localization.title_episodes)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            withAnimation {
                                self.isMenuOpen.toggle()
                            }
                        }, label: {
                            Image(systemName: "list.bullet")
                                .imageScale(.large)
                                .tint(self.colorByColorScheme)
                        })
                        .padding()
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            if self.isFiltered {
                                self.isFiltered = false
                                self.isPresented = false
                                self.episodes = self.originalEpisodes
                            } else {
                                self.isPresented = true
                            }
                        }
                    } label: {
                        FilterButtonView(isFiltered: $isFiltered)
                    }
                    .transition(.scale)
                    .padding(.trailing, 35)
                }
            }
            
            if self.isMenuOpen {
                HStack {
                    MenuView(isMenuOpen: $isMenuOpen, characters: self.characters, episodes: self.episodes)
                }
                .frame(maxHeight: .infinity)
                .transition(.move(edge: .trailing))
            }
        }
        .navigationBarBackButtonHidden()
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -100 {
                        withAnimation {
                            self.isMenuOpen = false
                        }
                    }
                }
        )
        .onTapGesture {
            withAnimation {
                self.isMenuOpen = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        EpisodesListView(episodes: [], characters: [])
            .environment(\.managedObjectContext, CoreDataProvider.preview.context)
            .environmentObject(SNKViewModel())
    }
}

extension EpisodesListView {
    private var localization: Localization {
        DefaultLocalization()
    }
    
    private var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    private var foregroundColorByColorScheme: Color {
        self.colorScheme == .dark ? .black : .white
    }
}
