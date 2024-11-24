//
//  MenuView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 22/11/2024.
//

import SwiftUI

struct MenuView: View {
    @Binding var isMenuOpen: Bool
    @Environment(\.colorScheme) private var colorScheme
    private var characters: [Characters]
    private var episodes: [Episodes]
    
    init(isMenuOpen: Binding<Bool>,
         characters: [Characters],
         episodes: [Episodes]) {
        self._isMenuOpen = isMenuOpen
        self.characters = characters
        self.episodes = episodes
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            self.isMenuOpen = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .padding()
                    .accessibilityIdentifier("menu_close_button")
                    
                }
                .foregroundStyle(self.colorByColorScheme)
                .padding()
                
                NavigationLink {
                    HomeView()
                        .onAppear {
                            self.isMenuOpen = false
                        }
                } label: {
                    HStack {
                        Image(systemName: "house.fill")
                        Text(self.localization.menu_home)
                            .font(.headline)
                    }
                    .foregroundStyle(self.colorByColorScheme)
                    .accessibilityIdentifier("menu_home_button")
                }
                .padding()
                
                NavigationLink {
                    CharactersListView(characters: self.characters,
                                       episodes: self.episodes)
                    .onAppear {
                        self.isMenuOpen = false
                    }
                } label: {
                    HStack {
                        Image(systemName: "person.fill")
                        Text(self.localization.title_characters)
                            .font(.headline)
                    }
                    .foregroundStyle(colorByColorScheme)
                    
                }
                .padding()
                .accessibilityIdentifier("menu_characters_button")
                
                NavigationLink {
                    EpisodesListView(episodes: self.episodes, characters: self.characters)
                        .onAppear {
                            isMenuOpen = false
                        }
                } label: {
                    HStack {
                        Image(systemName: "list.bullet.rectangle.fill")
                        Text(self.localization.title_episodes)
                            .font(.headline)
                    }
                    .foregroundStyle(self.colorByColorScheme)
                }
                .padding()
                .accessibilityIdentifier("menu_episodes_button")
                
                NavigationLink {
                    // SettingsView().onAppear { self.isMenuOpen = false }
                } label: {
                    HStack {
                        Image(systemName: "gear")
                        Text(self.localization.menu_settings)
                            .font(.headline)
                    }
                    .foregroundStyle(self.colorByColorScheme)
                }
                .padding()
                .accessibilityIdentifier("menu_settings_button")
                
                Spacer(minLength: 440)
            }
            .frame(maxWidth: UIScreen.main.bounds.width / 1.5, maxHeight: .infinity)
            .background(self.backgroundColorByColorScheme.opacity(0.7))
            .edgesIgnoringSafeArea(.all)
            .accessibilityIdentifier("lateral_menu")
        }
    }
}

extension MenuView {
    private var localization: Localization {
        DefaultLocalization()
    }
    
    private var colorByColorScheme: Color {
        self.colorScheme == .dark ? .black : .white
    }
    
    private var backgroundColorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
}
