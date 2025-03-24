//
//  TitanInheritorSection.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 24/3/25.
//

import SwiftUI

struct TitanInheritorSection: View {
    let titan: Titans
    let characters: [Characters]
    let coreDataProvider: CoreDataProvider
    @EnvironmentObject private var viewModel: SNKViewModel
    @State private var isZoomed: Bool = false
    
    private var helper: Helpers {
        DefaultHelpers()
    }

    var body: some View {
        Group {
            if let currentInheritorString = titan.current_inheritor {
                let currentInheritor = self.helper.getObjectById(string: currentInheritorString, objectArray: self.characters)
                
                VStack {
                    Text("Current Inheritor")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()

                    if let img = currentInheritor.img, let name = currentInheritor.name {
                        ImageView(isZoomed: $isZoomed, imageData: img, imageWidth: 200, imageHeight: 200)

                        Text(name)
                            .font(.body.bold())
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.all, 15)
                    }
                }
                .onAppear {
                    if !coreDataProvider.checkIsASpecificCharacterExisting(character: currentInheritor) {
                        viewModel.fetchCharacterById(id: String(currentInheritor.id))
                    }
                }
            }
        }
    }
}

