//
//  ButtonView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 24/11/2024.
//


import SwiftUI

struct ButtonView: View {
    private var titleLabel: String
    private var foregroundColor: Color
    private var backgroundColor: Color
    
    init(titleLabel: String, foregroundColor: Color, backgroundColor: Color) {
        self.titleLabel = titleLabel
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Text(self.titleLabel)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .background(self.backgroundColor)
            .foregroundColor(self.foregroundColor)
            .clipShape(.rect(cornerRadius: 15))
            .shadow(radius: 10)
    }
}

#Preview {
    ButtonView(titleLabel: "Test", foregroundColor: .white, backgroundColor: .cyan)
}
