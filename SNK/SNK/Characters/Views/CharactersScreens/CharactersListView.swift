//
//  CharactersListView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 23/11/2024.
//

import SwiftUI
import CoreData

struct CharactersListView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var viewModel: CharactersViewModel
    @State private var isMenuOpen: Bool = false
    @State private var isPresented: Bool = false
    @State private var isFiltered: Bool = false
    @State private var characters: [Characters]
    private var episodes: [Episodes]
    @State private var originalCharacters: [Characters]
    
    init(characters: [Characters], episodes: [Episodes]) {
        self.characters = characters
        self.episodes = episodes
        self.originalCharacters = characters
    }
    
    var body: some View {
        ZStack {
            if self.characters.isEmpty {
                EmptyListView(isFiltered: $isFiltered)
            } else {
                VStack {
                    TopBarView(isMenuOpen: $isMenuOpen,
                               textHeader: self.localization.title_characters)
                    .accessibilitySortPriority(1)
                    ScrollView {
                        LazyVStack {
                            ForEach(self.characters, id: \.self) { item in
                                NavigationLink {
                                    CharacterDetailView(character: item, characters: self.originalCharacters, episodes: self.episodes)
                                } label: {
                                    VStack {
                                        CharacterCellView(character: item, localization: self.localization)
                                            .padding()
                                            .accessibilityRemoveTraits(.isSelected)
                                        
                                        if item == self.characters.last && item.id < 201 && !self.isFiltered {
                                            self.loadMoreButton
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .disabled(self.isMenuOpen)
                .blur(radius: self.isMenuOpen ? 3 : 0)
                .sheet(isPresented: $isPresented, content: {
                    FilterView(isCharacter: true) { name, status, _ in
                        self.isFiltered = name.isEmpty && status == .none ? false : true
                        self.characters = self.viewModel.filterCharacters(filterName: name, filterStatus: status)
                    }
                })
                .navigationBarBackButtonHidden()
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
                                self.characters = self.originalCharacters
                            } else {
                                self.isPresented = true
                            }
                        }
                    } label: {
                        FilterButtonView(isFiltered: $isFiltered)
                    }
                    .transition(.scale)
                    .padding(.trailing, 25)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(self.isFiltered ? self.localization.accessibility_clear_btn : self.localization.accessibility_filter_btn)
            
            if isMenuOpen {
                HStack {
                    MenuView(isMenuOpen: $isMenuOpen, characters: self.characters, episodes: self.episodes)
                }
                .frame(maxHeight: .infinity)
                .transition(.move(edge: .trailing))
            }
        }
        .background(LinearGradient(colors: [Color(.backgroundOne), Color(.backgroundTwo)],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
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

extension CharactersListView {
    private var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    private var localization: Localization {
        DefaultLocalization()
    }
    
    private var loadMoreButton: some View {
        Button {
            Task {
                await self.viewModel.fetchCharacters()
            }
            self.characters = self.viewModel.characters
            self.originalCharacters = self.viewModel.characters
        } label: {
            HStack {
                Image(systemName: "arrow.2.circlepath")
                Text(self.localization.load_more_data)
            }
        }
        .font(.title3)
        .foregroundStyle(self.colorByColorScheme)
    }
}
