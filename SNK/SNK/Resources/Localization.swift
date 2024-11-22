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
    var menu_characters: String { get }
    var menu_episodes: String { get }
    var menu_settings: String { get }
}

struct DefaultLocalization: Localization {
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
    
    var menu_characters: String {
        return customLocalizedString("menu_characters")
    }
    
    var menu_episodes: String {
        return customLocalizedString("menu_episodes")
    }
    
    var menu_settings: String {
        return customLocalizedString("menu_settings")
    }
}

// MARK: - Helpers
extension DefaultLocalization {
    func customLocalizedString(_ key: String) -> String {
        return Bundle.localizedString(forKey: key, value: nil, table: nil)
    }
}
