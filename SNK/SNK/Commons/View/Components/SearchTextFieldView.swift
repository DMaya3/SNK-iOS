//
//  SearchTextFieldView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//

import SwiftUI

struct SearchTextFieldView: View {
    @Binding var text: String
    var label: String
    
    var body: some View {
        TextField(self.label, text: $text)
            .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 5))
            .background(Color(.filter).opacity(0.1))
            .colorMultiply(Color(.filter))
            .cornerRadius(12)
            .padding()
    }
}

#Preview {
    SearchTextFieldView(text: .constant("Text test"), label: "Test Label")
}
