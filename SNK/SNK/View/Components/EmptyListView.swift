//
//  EmptyListView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 24/11/2024.
//

import SwiftUI

struct EmptyListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @Binding var isFiltered: Bool
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Image(.titanFilter)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height - 140)
                        .opacity(0.3)
                        .padding()
                }
            }
            VStack {
                Text(self.localization.empty_list_description)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.all, 30)
                
                if !self.isFiltered {
                    NavigationLink {
                        HomeView()
                    } label: {
                        VStack {
                            ButtonView(titleLabel: self.localization.menu_home,
                                       foregroundColor: self.foregroundColorByColorScheme,
                                       backgroundColor: self.colorByColorScheme)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .background(LinearGradient(
            colors: [Color(.backgroundOne), Color(.backgroundTwo)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing))
        .padding()
    }
}

extension EmptyListView {
    private var localization: Localization {
        DefaultLocalization()
    }
    
    private var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
    
    private var foregroundColorByColorScheme: Color {
        self.colorScheme == .dark ? .black : .white
    }
}
