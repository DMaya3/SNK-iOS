//
//  ContentView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(entity: Characters.entity, sortDescriptors: [NSSortDescriptor(key: "id", ascending: true)]) public var characters: FetchedResults<Characters>
    @FetchRequest(entity: Episodes.entity, sortDescriptors: [NSSortDescriptor(key: "id", ascending: true)]) public var episodes: FetchedResults<Episodes>
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var viewModel: SNKViewModel
    @Namespace private var nameSpace
    @State private var showWebView: Bool = false
    @State private var isMenuOpen: Bool = false

    var body: some View {
        NavigationStack {
            if self.characters.count < 20 && self.episodes.count < 20 {
                LoadingView()
            } else {
                ZStack {
                    VStack {
                        ScrollView {
                            Text(self.localization.title_home_view)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(self.colorByColorScheme)
                                .frame(alignment: .center)
                                .accessibilityAddTraits(.isHeader)
                                .accessibilitySortPriority(3)
                            
                            Text(self.localization.description_home_view)
                                .font(.subheadline)
                                .foregroundStyle(self.colorByColorScheme)
                                .multilineTextAlignment(.leading)
                                .frame(width: UIScreen.main.bounds.width - 60)
                                .padding()
                            
                            Text(self.localization.title_sections_home_view)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(self.colorByColorScheme)
                                .frame(alignment: .center)
                                .accessibilityAddTraits(.isHeader)
                            
                            NavigationLink {
                                if #available(iOS 18.0, *) {
                                    CharactersListView(characters: Array(self.characters), episodes: Array(self.episodes))
                                     .navigationTransition(.zoom(sourceID: "CharactersList", in: nameSpace))
                                } else {
                                    CharactersListView(characters: Array(self.characters), episodes: Array(self.episodes))
                                }
                            } label: {
                                if #available(iOS 18.0, *) {
                                    CardSectionView(titleSection: self.localization.title_section_characters_home_view, characters: Array(self.characters))
                                        .matchedTransitionSource(id: "CharactersList", in: nameSpace)
                                } else {
                                    CardSectionView(titleSection: self.localization.title_section_characters_home_view, characters: Array(self.characters))
                                }
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(self.localization.title_section_characters_home_view)
                            .accessibilityAddTraits(.isButton)
                            
                            NavigationLink {
                                if #available(iOS 18.0, *) {
                                    EpisodesListView(episodes: Array(self.episodes), characters: Array(self.characters))
                                     .navigationTransition(.zoom(sourceID: "EpisodesList", in: nameSpace))
                                } else {
                                     EpisodesListView(episodes: Array(self.episodes), characters: Array(self.characters))
                                }
                            } label: {
                                if #available(iOS 18.0, *) {
                                    CardSectionView(titleSection: self.localization.title_section_episodes_home_view, episodes: Array(self.episodes))
                                        .matchedTransitionSource(id: "EpisodesList", in: nameSpace)
                                } else {
                                    CardSectionView(titleSection: self.localization.title_section_episodes_home_view, episodes: Array(self.episodes))
                                }
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(self.localization.title_section_episodes_home_view)
                            .accessibilityAddTraits(.isButton)
                            
                            Text(self.localization.text_more_info_home_view)
                                .font(.subheadline)
                                .foregroundStyle(self.colorByColorScheme)
                                .multilineTextAlignment(.center)
                                .frame(width: UIScreen.main.bounds.width - 60)
                                .padding(EdgeInsets(top: 1.5,
                                                    leading: 25,
                                                    bottom: 10,
                                                    trailing: 25))
                            
                            Text(self.localization.link_more_info_home_view)
                                .font(.footnote)
                                .foregroundStyle(.blue)
                                .onTapGesture {
                                    self.showWebView = true
                                }
                                .accessibilityAddTraits(.isLink)
                        }
                        .frame(width: UIScreen.main.bounds.width)
                        .background(LinearGradient(colors: [Color(.backgroundOne), Color(.backgroundTwo)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .sheet(isPresented: $showWebView) {
                            if let url = URL(string: "https://attackontitan.fandom.com/wiki/Attack_on_Titan_Wiki") {
                                WebView(url: url)
                            }
                        }
                        .navigationBarBackButtonHidden()
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Image(.wingsOfFreedom)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .accessibilityHidden(true)
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
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel(self.localization.accessibility_toolbar_menu_btn)
                            }
                        }
                    }
                    .disabled(self.isMenuOpen)
                    .blur(radius: self.isMenuOpen ? 3 : 0)
                    if self.isMenuOpen {
                        HStack {
                            MenuView(isMenuOpen: $isMenuOpen,
                                     characters: Array(self.characters),
                                     episodes: Array(self.episodes))
                        }
                        .frame(maxWidth: .infinity)
                        .transition(.move(edge: .trailing))
                    }
                }
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
        
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(SNKViewModel())
            .environment(\.managedObjectContext, CoreDataProvider.preview.context)
    }
}

extension HomeView {
    private var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    private var localization: Localization {
        DefaultLocalization()
    }
}
