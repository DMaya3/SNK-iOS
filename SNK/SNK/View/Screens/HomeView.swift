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
    
    var body: some View {
        NavigationStack {
            if self.characters.count < 20 && self.episodes.count < 20 {
                //LoadingView()
            } else {
                ZStack {
                    VStack {
                        ScrollView {
                            Text("Welcome to Shingeki No Kyojin App!")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(self.colorByColorScheme)
                                .frame(alignment: .center)
                            
                            Text("You´ll watch all about Attack On Titan. From characters to a list of episodes and more information. You´ll can watch all their information in detail like residence, age, specie, etc. Enjoy it!")
                                .font(.subheadline)
                                .foregroundStyle(self.colorByColorScheme)
                                .multilineTextAlignment(.leading)
                                .frame(width: UIScreen.main.bounds.width - 60)
                                .padding()
                            
                            Text("What do you want to watch first?")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(self.colorByColorScheme)
                                .frame(alignment: .center)
                            
                            NavigationLink {
                                if #available(iOS 18.0, *) {
                                    // CharactersListView()
                                    // .navigationTransition(.zoom(sourceID: "CharactersList", in: nameSpace)
                                } else {
                                    // CharactersListView()
                                }
                            } label: {
                                if #available(iOS 18.0, *) {
                                    CardSectionView(titleSection: "Characters", characters: Array(self.characters))
                                        .matchedTransitionSource(id: "CharactersList", in: nameSpace)
                                } else {
                                    CardSectionView(titleSection: "Characters", characters: Array(self.characters))
                                }
                            }
                            
                            NavigationLink {
                                if #available(iOS 18.0, *) {
                                    // EpisodesListView()
                                    // .navigationTransition(.zoom(sourceID: "CharactersList", in: nameSpace)
                                } else {
                                    // EpisodesListView()
                                }
                            } label: {
                                if #available(iOS 18.0, *) {
                                    CardSectionView(titleSection: "Episodes", episodes: Array(self.episodes))
                                        .matchedTransitionSource(id: "CharactersList", in: nameSpace)
                                } else {
                                    CardSectionView(titleSection: "Episodes", episodes: Array(self.episodes))
                                }
                            }
                            
                            Text("If you want to know more about the manga/anime tap the link down below!")
                                .font(.subheadline)
                                .foregroundStyle(self.colorByColorScheme)
                                .multilineTextAlignment(.center)
                                .frame(width: UIScreen.main.bounds.width - 60)
                                .padding(EdgeInsets(top: 1.5,
                                                    leading: 25,
                                                    bottom: 10,
                                                    trailing: 25))
                            
                            Text("Learn more about Shingeki No Kyojin")
                                .font(.footnote)
                                .foregroundStyle(.blue)
                                .onTapGesture {
                                    self.showWebView = true
                                }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                        .background(LinearGradient(colors: [Color(.backgroundOne), Color(.backgroundTwo)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .sheet(isPresented: $showWebView) {
                            if let url = URL(string: "https://attackontitan.fandom.com/wiki/Attack_on_Titan_Wiki") {
                                WebView(url: url)
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Image(.wingsOfFreedom)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding()
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                Image(systemName: "list.bullet")
                                    .imageScale(.large)
                                    .tint(self.colorByColorScheme)
                            }
                        }
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
    var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
}
