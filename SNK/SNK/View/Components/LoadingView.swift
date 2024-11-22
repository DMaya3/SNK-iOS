//
//  LoadingView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 22/11/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Image(.wingsOfFreedomLoading)
                .resizable()
                .scaledToFill()
                .frame(height: 900)
        }
    }
}

#Preview {
    LoadingView()
}
