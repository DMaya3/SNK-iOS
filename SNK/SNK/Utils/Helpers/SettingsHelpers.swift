//
//  SettingsHelpers.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 25/11/2024.
//

import Foundation

class ColorSchemeManager: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(self.isDarkMode, forKey: "isDarkMode")
        }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
}

enum Language: String, CaseIterable, Identifiable {
    case english = "en"
    case spanish = "es"
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .english:
            return "English"
        case .spanish:
            return "Spanish"
        }
    }
}
class LanguageSettings: ObservableObject {
    @Published var selectedLanguage: Language {
        didSet {
            UserDefaults.standard.set(selectedLanguage.rawValue, forKey: "appLanguage")
            UserDefaults.standard.synchronize()
            updateLanguage()
        }
    }
    
    init() {
        let savedLanguage = UserDefaults.standard.string(forKey: "appLanguage") ?? Language.english.rawValue
        self.selectedLanguage = Language(rawValue: savedLanguage) ?? .english
        updateLanguage()
    }
    
    func updateLanguage() {
        Bundle.setLanguage(self.selectedLanguage.rawValue)
    }
}

private var bundleKey: UInt8 = 0

extension Bundle {
    class func setLanguage(_ language: String) {
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle.main, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey, bundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    static func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle = objc_getAssociatedObject(Bundle.main, &bundleKey) as? Bundle ?? Bundle.main
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}
