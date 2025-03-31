//
//  SectionView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 24/11/2024.
//

import SwiftUI

struct SectionView: View {
    @Environment(\.colorScheme) var colorScheme
    private var stringArray: [String]
    private var nameSection: String
    
    var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    init(nameSection: String, stringArray: [String]) {
        self.nameSection = nameSection
        self.stringArray = stringArray
    }
    
    var body: some View {
        Text(self.nameSection)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(self.colorByColorScheme)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .accessibilityAddTraits(.isHeader)
        ForEach(self.stringArray, id: \.self) { string in
            if string != "" {
                HStack {
                    Image(systemName: "dot.circle")
                        .tint(self.colorByColorScheme)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                        .accessibilityHidden(true)
                    Text(string)
                        .foregroundStyle(self.colorByColorScheme)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            }
        }
    }
}
