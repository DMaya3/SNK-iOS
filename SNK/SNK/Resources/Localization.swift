//
//  Localization.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 22/11/2024.
//

import Foundation

protocol Localization {
    var title_home_view: String { get }
    var description_home_view: String { get }
    var title_sections_home_view: String { get }
    var title_section_characters_home_view: String { get }
    var title_section_episodes_home_view: String { get }
    var text_more_info_home_view: String { get }
    var link_more_info_home_view: String { get }
    
    var menu_home: String { get }
    var menu_settings: String { get }
    
    func name_charlist_view(name: String) -> String
    func age_charlist_view(age: String) -> String
    func status_charlist_view(status: String) -> String
    
    var title_characters: String { get }
    var title_episodes: String { get }
}

struct DefaultLocalization: Localization {
    private var languageSetting = LanguageSettings()
    
    // MARK: - Home View
    var title_home_view: String {
        return customLocalizedString("title_home_view")
    }
    
    var description_home_view: String {
        return customLocalizedString("description_home_view")
    }
    
    var title_sections_home_view: String {
        return customLocalizedString("title_sections_home_view")
    }
    
    var title_section_characters_home_view: String {
        return customLocalizedString("title_section_characters_home_view")
    }
    
    var title_section_episodes_home_view: String {
        return customLocalizedString("title_section_episodes_home_view")
    }
    
    var text_more_info_home_view: String {
        return customLocalizedString("text_more_info_home_view")
    }
    
    var link_more_info_home_view: String {
        return customLocalizedString("link_more_info_home_view")
    }
    
    // MARK: - Menu View
    var menu_home: String {
        return customLocalizedString("menu_home")
    }
    
    var menu_settings: String {
        return customLocalizedString("menu_settings")
    }
    
    // MARK: - Characters List View
    func name_charlist_view(name: String) -> String {
        let format = customLocalizedString("name_charlist_view")
        return String(format: format, name)
    }
    
    func age_charlist_view(age: String) -> String {
        let format = customLocalizedString("age_charlist_view")
        return String(format: format, age)
    }
    
    func status_charlist_view(status: String) -> String {
        let format = customLocalizedString("status_charlist_view")
        let finalStatus = self.languageSetting.selectedLanguage.rawValue.contains("es") ? self.translateStatusToSP(status: status) : status
        return String(format: format, finalStatus)
    }
    
    // MARK: - Commons
    var title_characters: String {
        return customLocalizedString("title_characters")
    }
    
    var title_episodes: String {
        return customLocalizedString("title_episodes")
    }
}

// MARK: - Helpers
extension DefaultLocalization {
    func customLocalizedString(_ key: String) -> String {
        return Bundle.localizedString(forKey: key, value: nil, table: nil)
    }
    
    func translateStatusToSP(status: String) -> String {
        let statusTranslate = Status(rawValue: status)
        switch statusTranslate {
        case .alive:
            return "Vivo"
        case .deceased:
            return "Fallecido"
        case .unknown:
            return "Desconocido"
        case .none?:
            return "Ninguno"
        default:
            return ""
        }
    }
}
