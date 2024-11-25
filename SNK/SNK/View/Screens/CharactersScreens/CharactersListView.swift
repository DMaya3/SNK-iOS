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
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: SNKViewModel
    @State private var isMenuOpen: Bool = false
    private var characters: [Characters]
    private var episodes: [Episodes]
    
    init(characters: [Characters], episodes: [Episodes]) {
        self.characters = characters
        self.episodes = episodes
    }
    
    var body: some View {
        ZStack {
            if self.characters.isEmpty {
                EmptyListView()
            } else {
                VStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(self.characters, id: \.self) { item in
                                NavigationLink {
                                    CharacterDetailView(character: item, characters: self.characters, episodes: self.episodes)
                                } label: {
                                    VStack {
                                        HStack {
                                            ImageView(imageData: item.img,
                                                      imageWidth: 125,
                                                      imageHeight: 125)
                                            VStack {
                                                if let name = item.name, name != "" {
                                                    Text(self.localization.name_charlist_view(name: name))
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .font(.headline)
                                                        .multilineTextAlignment(.leading)
                                                        .foregroundStyle(self.colorByColorScheme)
                                                        .padding(.trailing, 15)
                                                }
                                                if item.status == Status.alive.rawValue && item.age > 0 {
                                                    Text(self.localization.age_charlist_view(age: String(item.age)))
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .font(.subheadline)
                                                        .foregroundStyle(self.colorByColorScheme)
                                                }
                                                HStack {
                                                    if let statusString = item.status, statusString != "" {
                                                        Text(self.localization.status_charlist_view(status: statusString))
                                                            .foregroundStyle(self.colorByColorScheme)
                                                        let status = Status(rawValue: statusString) ?? .none
                                                        self.getIconByStatus(status: status)
                                                        Spacer()
                                                    }
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
                .navigationBarBackButtonHidden()
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
                        Text(self.localization.title_characters)
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

#Preview {
    CharactersListView(characters: [], episodes: [])
}

extension CharactersListView {
    private var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    private var localization: Localization {
        DefaultLocalization()
    }
    
    func getIconByStatus(status: Status) -> some View {
        switch status {
        case .alive:
            return Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
        case .deceased:
            return Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.red)
        case .unknown:
            return Image(systemName: "exclamationmark.circle.fill")
                .foregroundStyle(.yellow)
        case .none:
            return Image(systemName: "questionmark.circle.dashed")
                .foregroundStyle(.gray)
        }
    }
}
