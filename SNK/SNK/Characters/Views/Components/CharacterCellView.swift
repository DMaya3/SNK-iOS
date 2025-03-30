//
//  CharacterCellView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 29/3/25.
//

import SwiftUI

struct CharacterCellView: View {
    private var character: Characters
    private var localization: Localization
    @Environment(\.colorScheme) private var colorShceme
    
    init(character: Characters, localization: Localization) {
        self.character = character
        self.localization = localization
    }
    
    var body: some View {
        HStack {
            ImageView(imageData: character.img,
                      imageWidth: 125,
                      imageHeight: 125)
            VStack {
                if let name = character.name, name != "" {
                    Text(self.localization.name_charlist_view(name: name))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(self.colorByColorScheme)
                        .padding(.trailing, 15)
                }
                if character.status == Status.alive.rawValue && character.age > 0 {
                    Text(self.localization.age_charlist_view(age: String(character.age)))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .foregroundStyle(self.colorByColorScheme)
                }
                HStack {
                    if let statusString = character.status, statusString != "" {
                        Text(self.localization.status_charlist_view(status: statusString))
                            .font(.subheadline)
                            .foregroundStyle(self.colorByColorScheme)
                        let status = Status(rawValue: statusString) ?? .none
                        self.getIconByStatus(status: status)
                        Spacer()
                    }
                }
            }
        }
    }
}

extension CharacterCellView {
    private var colorByColorScheme: Color {
        colorShceme == .dark ? .white : .black
    }
    
    func getIconByStatus(status: Status) -> some View {
        switch status {
        case .alive:
            return Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
        case .deceased:
            return Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.red)
        case .unknown:
            return Image(systemName: "exclamationmark.circle.fill")
                .foregroundStyle(.yellow)
        case .none:
            return Image(systemName: "questionmark.circle.dashed")
                .foregroundStyle(.gray)
        }
    }
}
