//
//  EpisodeCellView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 30/3/25.
//

import SwiftUI

struct EpisodeCellView: View {
    @Environment(\.colorScheme) private var colorScheme
    private var episode: Episodes
    
    init(episode: Episodes) {
        self.episode = episode
    }
    
    var body: some View {
        HStack {
            ImageView(imageData: self.episode.img,
                      imageWidth: 125,
                      imageHeight: 125)
            VStack {
                if let name = self.episode.name, name != "" {
                    Text(self.localization.name_charlist_view(name: name))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(self.colorByColorScheme)
                        .padding(.trailing, 10)
                }
                if let episode = self.episode.episode, episode != "" {
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

extension EpisodeCellView {
    var localization: Localization {
        DefaultLocalization()
    }
    
    var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
}
