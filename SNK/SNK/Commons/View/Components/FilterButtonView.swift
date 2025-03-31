//
//  FilterButtonView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//


import SwiftUI

struct FilterButtonView: View {
    @Binding var isFiltered: Bool
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Image(systemName: self.isFiltered ? "xmark.circle.fill" : "slider.horizontal.3")
            .font(.system(size: 24))
            .foregroundColor(self.foregroundIconColorByColorScheme)
            .padding()
            .background(self.colorByColorScheme)
            .clipShape(Circle())
            .shadow(radius: 5)
            .animation(.easeInOut, value: self.isFiltered)
    }
}

extension FilterButtonView {
    var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    var foregroundIconColorByColorScheme: Color {
        self.colorScheme == .dark ? .black : .white
    }
}
