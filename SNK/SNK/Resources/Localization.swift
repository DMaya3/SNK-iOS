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
    
    func cdv_name_and_age(name: String, age: String) -> String
    var cdv_alias: String { get }
    func cdv_residence(birthplace: String, residence: String) -> String
    var cdv_section_species: String { get }
    func cdv_species(specie: String) -> String
    func cdv_section_family(family: String) -> String
    var cdv_section_roles: String { get }
    var cdv_section_episodes: String { get }
    
    func edv_season_title(number: String) -> String
    func edv_episode_title(number: String, title: String) -> String
}

struct DefaultLocalization: Localization {
    private var languageSetting = LanguageSettings()
    
    // MARK: - Home View
    var title_home_view: String {
        return self.customLocalizedString("title_home_view")
    }
    
    var description_home_view: String {
        return self.customLocalizedString("description_home_view")
    }
    
    var title_sections_home_view: String {
        return self.customLocalizedString("title_sections_home_view")
    }
    
    var title_section_characters_home_view: String {
        return self.customLocalizedString("title_section_characters_home_view")
    }
    
    var title_section_episodes_home_view: String {
        return self.customLocalizedString("title_section_episodes_home_view")
    }
    
    var text_more_info_home_view: String {
        return self.customLocalizedString("text_more_info_home_view")
    }
    
    var link_more_info_home_view: String {
        return self.customLocalizedString("link_more_info_home_view")
    }
    
    // MARK: - Menu View
    var menu_home: String {
        return self.customLocalizedString("menu_home")
    }
    
    var menu_settings: String {
        return self.customLocalizedString("menu_settings")
    }
    
    // MARK: - Characters List View
    func name_charlist_view(name: String) -> String {
        let format = self.customLocalizedString("name_charlist_view")
        return String(format: format, name)
    }
    
    func age_charlist_view(age: String) -> String {
        let format = self.customLocalizedString("age_charlist_view")
        return String(format: format, age)
    }
    
    func status_charlist_view(status: String) -> String {
        let format = self.customLocalizedString("status_charlist_view")
        let finalStatus = self.languageSetting.selectedLanguage.rawValue.contains("es") ? self.translateStatusToSP(status: status) : status
        return String(format: format, finalStatus)
    }
    
    // MARK: - Commons
    var title_characters: String {
        return self.customLocalizedString("title_characters")
    }
    
    var title_episodes: String {
        return self.customLocalizedString("title_episodes")
    }
    
    // MARK: - Character Detail View
    func cdv_name_and_age(name: String, age: String) -> String {
        let format = self.customLocalizedString("cdv_name_and_age")
        return String(format: format, name, age)
    }
    
    var cdv_alias: String {
        return self.customLocalizedString("cdv_alias")
    }
    
    func cdv_residence(birthplace: String, residence: String) -> String {
        let format = self.customLocalizedString("cdv_residence")
        return String(format: format, birthplace, residence)
    }
    
    var cdv_section_species: String {
        return self.customLocalizedString("cdv_section_species")
    }
    
    func cdv_species(specie: String) -> String {
        let format = self.customLocalizedString("cdv_species")
        let finalSpecie = self.languageSetting.selectedLanguage.rawValue.contains("es") ? self.translateSpeciesToSP(specie: specie) : specie
        return String(format: format, finalSpecie)
    }
    
    func cdv_section_family(family: String) -> String {
        let format = self.customLocalizedString("cdv_section_family")
        let finalFamily = self.languageSetting.selectedLanguage.rawValue.contains("es") ? self.reverseAndReplace(in: family) : family
        return String(format: format, finalFamily)
    }
    
    var cdv_section_roles: String {
        return self.customLocalizedString("cdv_section_roles")
    }
    
    var cdv_section_episodes: String {
        return self.customLocalizedString("cdv_section_episodes")
    }
    
    // MARK: - Episode Detail View
    func edv_season_title(number: String) -> String {
        let format = self.customLocalizedString("edv_season_title")
        return String(format: format, number)
    }
    
    func edv_episode_title(number: String, title: String) -> String {
        let format = self.customLocalizedString("edv_episode_title")
        return String(format: format, number, title)
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
    
    func translateSpeciesToSP(specie: String) -> String {
        let specieTranslate = Species(rawValue: specie)
        switch specieTranslate {
        case .human:
            return "Humano"
        case .intelligentTItan:
            return "Titán inteligente"
        case .titanFormerlyHuman:
            return "Titán (antes humano)"
        case nil:
            return ""
        }
    }
    
    func reverseAndReplace(in sentence: String) -> String {
        var words = sentence.split(separator: " ").map(String.init)
        if let index = words.firstIndex(of: "family") {
            words[index] = "Familia"
        }
        let reversedWrods = words.reversed()
        return reversedWrods.joined(separator: " ")
    }
}
