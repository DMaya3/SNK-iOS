//
//  Untitled.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 21/11/2024.
//

import SwiftUI

struct CardSectionView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var currentIndex: Int = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    private var titleSection: String
    private var characters: [Characters]
    private var episodes: [Episodes]
    
    init(titleSection: String, characters: [Characters] = [], episodes: [Episodes] = []) {
        self.titleSection = titleSection
        self.characters = characters
        self.episodes = episodes
    }
    
    var body: some View {
        VStack {
            HStack {
                if !self.characters.isEmpty {
                    self.displayImage(self.characters[self.currentIndex].img)
                } else if !self.episodes.isEmpty {
                    self.displayImage(self.episodes[self.currentIndex].img)
                } else {
                    Image(.wingsOfFreedom)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 170)
                        .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
            .onReceive(self.timer) { _ in
                withAnimation {
                    if !self.characters.isEmpty {
                        self.currentIndex = Int.random(in: 0..<self.characters.count)
                    }
                    
                    if !self.episodes.isEmpty {
                        self.currentIndex = Int.random(in: 0..<self.episodes.count)
                    }
                }
            }
            Text(titleSection)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(self.colorByColorScheme)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 10)
            Spacer()
        }
        .background(LinearGradient(colors: [Color(.backgroundOne), Color(.backgroundTwo)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .frame(width: 300, height: 200)
        .cornerRadius(15)
        .shadow(color: self.colorByColorScheme, radius: 6)
        .padding()
    }
}

extension CardSectionView {
    var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    func displayImage(_ imageData: Data?) -> some View {
        if let uiImage = UIImage(data: imageData ?? Data()) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 170)
                .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        } else {
            Image(.wingsOfFreedom)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 170)
                .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        }
    }
}
