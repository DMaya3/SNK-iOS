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
    var empty_list_description: String { get }
    var no_data: String { get }
    
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
    
    var settings_appearance_section: String { get }
    var settings_languages_section: String { get }
    var settings_dark_mode: String { get }
    var settings_select_language: String { get }
    
    var filter_title_header: String { get }
    var filter_name_hint: String { get }
    var filter_status_header: String { get }
    func filter_status_value(status: String) -> String
    var filter_season_header: String { get }
    func filter_season_title(season: String) -> String
    var filter_btn_apply: String { get }
    var filter_btn_cancel: String { get }
    var filter_btn_clear: String { get }
    
    var accessibility_toolbar_back_btn: String { get }
    var accessibility_toolbar_menu_btn: String { get }
    var accessibility_filter_btn: String { get }
    var accessibility_clear_btn: String { get }
    var accessibility_swipe_carousel: String { get }
    var accessibility_toolbar_home: String { get }
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
    
    var empty_list_description: String {
        return self.customLocalizedString("empty_list_description")
    }
    
    var no_data: String {
        return self.customLocalizedString("no_data")
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
    
    // MARK: - Settings View
    var settings_appearance_section: String {
        return self.customLocalizedString("settings_appearance_section")
    }
    
    var settings_languages_section: String {
        return self.customLocalizedString("settings_languages_section")
    }
    
    var settings_dark_mode: String {
        return self.customLocalizedString("settings_dark_mode")
    }
    
    var settings_select_language: String {
        return self.customLocalizedString("settings_select_language")
    }
    
    // MARK: - Filter View
    var filter_title_header: String {
        return self.customLocalizedString("filter_title_header")
    }
    
    var filter_name_hint: String {
        return self.customLocalizedString("filter_name_hint")
    }
    
    var filter_status_header: String {
        return self.customLocalizedString("filter_status_header")
    }
    
    func filter_status_value(status: String) -> String {
        let format = self.customLocalizedString("filter_status_value")
        let finalStatus = self.languageSetting.selectedLanguage.rawValue.contains("es") ? self.translateStatusToSP(status: status) : status
        return String(format: format, finalStatus)
    }
    
    var filter_season_header: String {
        return self.customLocalizedString("filter_season_header")
    }
    
    func filter_season_title(season: String) -> String {
        let format = self.customLocalizedString("filter_season_title")
        if season.contains("none") {
            return self.languageSetting.selectedLanguage.rawValue.contains("es") ? "Ninguna" : "None"
        }
        return String(format: format, season)
    }
    
    var filter_btn_apply: String {
        return self.customLocalizedString("filter_btn_apply")
    }
    
    var filter_btn_cancel: String {
        return self.customLocalizedString("filter_btn_cancel")
    }
    
    var filter_btn_clear: String {
        return self.customLocalizedString("filter_btn_clear")
    }
    
    // MARK: - Accessibility Labels
    var accessibility_toolbar_back_btn: String {
        return self.customLocalizedString("accessibility_toolbar_back_btn")
    }

    var accessibility_toolbar_menu_btn: String {
        return self.customLocalizedString("accessibility_toolbar_menu_btn")
    }
    
    var accessibility_filter_btn: String {
        return self.customLocalizedString("accessibility_filter_btn")
    }
    
    var accessibility_clear_btn: String {
        return self.customLocalizedString("accessibility_clear_btn")
    }
    
    var accessibility_swipe_carousel: String {
        return self.customLocalizedString("accessibility_swipe_carousel")
    }
    
    var accessibility_toolbar_home: String {
        return self.customLocalizedString("accessibility_toolbar_home")
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
