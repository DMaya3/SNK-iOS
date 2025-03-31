//
//  ImageView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 23/11/2024.
//


import SwiftUI
struct ImageView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var isZoomed: Bool
    private var imageData: Data?
    private var imageWidth: CGFloat
    private var imageHeight: CGFloat
    private var shadowRadius: CGFloat
    
    var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    init(isZoomed: Binding<Bool> = .constant(false),
         imageData: Data?,
         imageWidth: CGFloat,
         imageHeight: CGFloat,
         shadowRadius: CGFloat = 10) {
        self._isZoomed = isZoomed
        self.imageData = imageData
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.shadowRadius = shadowRadius
    }
    var body: some View {
        if let imageData = self.imageData {
            Image(uiImage: UIImage(data: imageData) ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: self.isZoomed ? 350 : self.imageWidth,
                       height: self.isZoomed ? 350 : self.imageHeight)
                .scaleEffect(self.isZoomed ? 2.0 : 1.0)
                .cornerRadius(20)
                .shadow(color: self.colorByColorScheme, radius: self.shadowRadius)
                .padding()
                .onTapGesture {
                    withAnimation {
                        self.isZoomed.toggle()
                    }
                }
                .accessibilityHidden(true)
        } else {
            Image(.wingsOfFreedom)
                .resizable()
                .scaledToFill()
                .frame(width: self.imageWidth, height: self.imageHeight)
                .padding()
                .accessibilityHidden(true)
        }
    }
}

#Preview {
    ImageView(isZoomed: .constant(false),
              imageData: Data(),
              imageWidth: 0,
              imageHeight: 0)
}
