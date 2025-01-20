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
    
    init(titans: [Titans],
         characters: [Characters]) {
        self.titans = titans
        self.characters = characters
    }
    
    var body: some View {
        ZStack {
            if self.titans.isEmpty {
                EmptyListView(isFiltered: .constant(false))
            } else {
                VStack {
                    TopBarView(isMenuOpen: $isMenuOpen,
                               textHeader: self.localization.title_titans)
                    .accessibilitySortPriority(1)
                    ScrollView {
                        TabView(selection: $currentIndex) {
                            ForEach(self.titans.indices, id: \.self) { index in
                                    VStack {
                                       if let image = self.titans[index].img_titan {
                                            Image(uiImage: UIImage(data: image) ?? UIImage())
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 200, height: 200)
                                                .cornerRadius(20)
                                                .shadow(color: self.colorByColorScheme,
                                                        radius: 10)
                                                .padding()
                                        } else {
                                            Text(self.localization.no_data)
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .frame(width: 200, height: 200)
                                                .padding()
                                        }
                                        
                                        if let name = self.titans[index].name {
                                            Text(name)
                                                .font(.body.bold())
                                                .foregroundStyle(self.colorByColorScheme)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                        }
                                        
                                        if let height = self.titans[index].height {
                                            Text(self.localization.titan_height(height: height))
                                                .font(.body.bold())
                                                .foregroundStyle(self.colorByColorScheme)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                        }
                                        
                                        if let currentInheritorString = self.titans[index].current_inheritor {
                                            let currentInheritor = self.helper.getObjectById(string: currentInheritorString, objectArray: self.characters)
                                            
                                            Text(self.localization.current_inheritor_section)
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundStyle(self.colorByColorScheme)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding()
                                            
                                            if let img = currentInheritor.img, let name = currentInheritor.name {
                                                ImageView(isZoomed: $isZoomed,
                                                          imageData: img,
                                                          imageWidth: 200,
                                                          imageHeight: 200)
                                                
                                                Text(name)
                                                    .font(.body.bold())
                                                    .foregroundStyle(self.colorByColorScheme)
                                                    .frame(maxWidth: .infinity, alignment: .center)
                                                    .padding(.all, 15)
                                            }
                                            
                                        }
                                        
                                        if let formerInheritorsString = self.titans[index].former_inheritors {
                                            SectionImageCarouselView(nameSection: self.localization.former_inheritors_section,
                                                                     members: formerInheritorsString,
                                                                     characters: self.characters)
                                        }
                                        
                                        Spacer()
                                    }
                                    .tag(index)
                            }
                        }
                        .frame(maxWidth: .infinity, idealHeight: UIScreen.main.bounds.height + 200, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
                .disabled(self.isMenuOpen)
                .blur(radius: self.isMenuOpen ? 3 : 0)
                .navigationBarBackButtonHidden()
            }
        }
        .background(LinearGradient(colors: [Color(.backgroundOne), Color(.backgroundTwo)],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
        
        if isMenuOpen {
            HStack {
                MenuView(isMenuOpen: $isMenuOpen, characters: self.characters, episodes: [])
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
    
    private var localization: Localization {
        DefaultLocalization()
    }
    
    private var helper: Helpers {
        DefaultHelpers()
    }
}

/*
 
 Text(self.localization.current_inheritor_section)
     .font(.title3)
     .fontWeight(.bold)
     .foregroundStyle(self.colorByColorScheme)
     .frame(maxWidth: .infinity, alignment: .leading)
     .padding()
 
 if let img = currentInheritor.img, let name = currentInheritor.name {
     ImageView(isZoomed: $isZoomed,
               imageData: img,
               imageWidth: 200,
               imageHeight: 200)
     
     Text(name)
         .font(.body.bold())
         .foregroundStyle(self.colorByColorScheme)
         .frame(maxWidth: .infinity, alignment: .center)
         .padding(.all, 15)
 }
 */
