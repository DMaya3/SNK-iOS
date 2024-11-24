//
//  Helpers.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//

import Foundation

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

enum Status: String, CaseIterable, Identifiable {
    var id: Self {
        self
    }
    case alive = "Alive"
    case deceased = "Deceased"
    case unknown = "Unknown"
    case none
}

enum Species: String {
    case human = "Human"
    case intelligentTItan = "Intelligent Titan"
    case titanFormerlyHuman = "Titan (formerly human)"
}

protocol ArrayConvertible {
    var id: Int64 { get }
    var name: String? { get }
    var img: Data? { get }
}

protocol Helpers {
    func getArrayObjectById(stringArray: [String], objectArray: [ArrayConvertible]) -> [ArrayConvertible]
}

struct DefaultHelpers: Helpers {
    func getArrayObjectById(stringArray: [String], objectArray: [ArrayConvertible]) -> [ArrayConvertible] {
        var newArrayObject: [ArrayConvertible] = []
        for string in stringArray {
            let components = string.split(separator: "/")
            if let lastComponent = components.last {
                objectArray.forEach { thisObject in
                    if lastComponent == String(thisObject.id) {
                        newArrayObject.append(thisObject)
                    }
                }
            }
        }
        return newArrayObject
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
