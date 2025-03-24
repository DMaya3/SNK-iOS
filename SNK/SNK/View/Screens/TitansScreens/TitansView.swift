//
//  TitansListView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 05/01/2025.
//

import SwiftUI
import CoreData

struct TitansView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: SNKViewModel
    @State private var isZoomed: Bool = false
    @State private var isMenuOpen: Bool = false
    @State private var currentIndex: Int = 0
    @State private var titans: [Titans]
    private var characters: [Characters]
    private var coreDataProvider = CoreDataProvider()
    
    init(titans: [Titans], characters: [Characters]) {
        self.titans = titans
        self.characters = characters
    }
    
    var body: some View {
        ZStack {
            if titans.isEmpty {
                EmptyListView(isFiltered: .constant(false))
            } else {
                VStack {
                    TopBarView(isMenuOpen: $isMenuOpen, textHeader: "Titans")
                        .accessibilitySortPriority(1)
                    
                    ScrollView {
                        TabView(selection: $currentIndex) {
                            ForEach(titans.indices, id: \.self) { index in
                                TitanCardView(titan: titans[index],
                                              colorScheme: colorByColorScheme,
                                              characters: characters,
                                              coreDataProvider: coreDataProvider)
                                    .tag(index)
                            }
                        }
                        .frame(maxWidth: .infinity, idealHeight: UIScreen.main.bounds.height + 200, alignment: .leading)
                        .padding(.horizontal, 15)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
                .disabled(isMenuOpen)
                .blur(radius: isMenuOpen ? 3 : 0)
                .navigationBarBackButtonHidden()
            }
        }
        .background(LinearGradient(colors: [Color(.backgroundOne), Color(.backgroundTwo)], startPoint: .topLeading, endPoint: .bottomTrailing))
        
        if isMenuOpen {
            HStack {
                MenuView(isMenuOpen: $isMenuOpen, characters: characters, episodes: [])
            }
            .frame(maxHeight: .infinity)
            .transition(.move(edge: .trailing))
        }
    }
}

extension TitansView {
    private var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
}
