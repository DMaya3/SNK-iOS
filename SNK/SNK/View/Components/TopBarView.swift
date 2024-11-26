//
//  TopBarView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 26/11/2024.
//


import SwiftUI

struct TopBarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @Binding var isMenuOpen: Bool
    private var textHeader: String
    
    private var localization: Localization {
        DefaultLocalization()
    }
    
    var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    init(isMenuOpen: Binding<Bool>, textHeader: String) {
        self._isMenuOpen = isMenuOpen
        self.textHeader = textHeader
    }
    
    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(self.colorByColorScheme)
                    .font(.title3)
            }
            .padding()
            .accessibilityElement(children: .combine)
            .accessibilityLabel(self.localization.accessibility_toolbar_back_btn)
            .accessibilityAddTraits(.isButton)
            Spacer()
            
            Text(self.textHeader)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(alignment: .center)
                .padding()
                .accessibilityAddTraits(.isHeader)
                .accessibilitySortPriority(3)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    self.isMenuOpen.toggle()
                }
            }, label: {
                Image(systemName: "list.bullet")
                    .imageScale(.large)
                    .tint(self.colorByColorScheme)
            })
            .padding()
            .accessibilityElement(children: .combine)
            .accessibilityLabel(self.localization.accessibility_toolbar_menu_btn)
            .accessibilityAddTraits(.isButton)
            .accessibilitySortPriority(2)
        }
    }
}
