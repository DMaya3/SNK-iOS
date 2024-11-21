//
//  SNKApp.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//

import SwiftUI

@main
struct SNKApp: App {
    init() {
        ValueTransformer.setValueTransformer(CharactersArrayTransformer(), forName: NSValueTransformerName("CharactersArrayTransformer"))
        ValueTransformer.setValueTransformer(EpisodesArrayTransformer(), forName: NSValueTransformerName("EpisodesArrayTransformer"))
        ValueTransformer.setValueTransformer(GroupsArrayTransformer(), forName: NSValueTransformerName("GroupsArrayTransformer"))
        ValueTransformer.setValueTransformer(InformationTransformer(), forName: NSValueTransformerName("InformationTransformer"))
        ValueTransformer.setValueTransformer(RelativesArrayTransformer(), forName: NSValueTransformerName("RelativesArrayTransformer"))
    }
    @StateObject private var viewModel = SNKViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.preview.context)
                .environmentObject(self.viewModel)
        }
    }
}
