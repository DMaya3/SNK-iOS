//
//  TitanCardView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 24/3/25.
//

import SwiftUI

struct TitanCardView: View {
    let titan: Titans
    let colorScheme: Color
    let characters: [Characters]
    let coreDataProvider: CoreDataProvider
    @EnvironmentObject private var viewModel: SNKViewModel
    @State private var isZoomed: Bool = false
    
    var body: some View {
        VStack {
            if let image = titan.img_titan {
                Image(uiImage: UIImage(data: image) ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
                    .shadow(color: colorScheme, radius: 10)
                    .padding()
            } else {
                Text("No Data")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 200, height: 200)
                    .padding()
            }

            if let name = titan.name {
                Text(name)
                    .font(.body.bold())
                    .foregroundStyle(colorScheme)
                    .frame(maxWidth: .infinity, alignment: .center)
            }

            if let height = titan.height {
                Text("Height: \(height)")
                    .font(.body.bold())
                    .foregroundStyle(colorScheme)
                    .frame(maxWidth: .infinity, alignment: .center)
            }

            TitanInheritorSection(titan: titan, characters: characters, coreDataProvider: coreDataProvider)
        }
    }
}
