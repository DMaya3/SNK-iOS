//
//  SettingsView.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("DarMode") var darkMode: Bool = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var colorSchemeManager: ColorSchemeManager
    @EnvironmentObject private var languageSettings: LanguageSettings

    var body: some View {
        ZStack {
            VStack {
                List {
                    Section {
                        Toggle(self.localization.settings_dark_mode, isOn: $colorSchemeManager.isDarkMode)
                    } header: {
                        Text(self.localization.settings_appearance_section)
                    }
                    
                    Section {
                        Picker(self.localization.settings_select_language, selection: $languageSettings.selectedLanguage) {
                            ForEach(Language.allCases) { language in
                                Text(language.displayName).tag(language)
                            }
                        }
                        .pickerStyle(.menu)
                    } header: {
                        Text(self.localization.settings_languages_section)
                    }
                }
            }
            .preferredColorScheme(self.colorSchemeManager.isDarkMode ? .dark : .light)
            .animation(.easeInOut(duration: 0.5), value: self.colorSchemeManager.isDarkMode)
            .background(LinearGradient(colors: [Color(.backgroundOne), Color(.backgroundTwo)],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
            .onAppear {
                self.darkMode = self.colorSchemeManager.isDarkMode
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(self.colorByColorScheme)
                            .font(.title3)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ColorSchemeManager())
        .environmentObject(LanguageSettings())
}

extension SettingsView {
    private var localization: Localization {
        DefaultLocalization()
    }
    
    private var colorByColorScheme: Color {
        self.colorScheme == .dark ? .white : .black
    }
}
