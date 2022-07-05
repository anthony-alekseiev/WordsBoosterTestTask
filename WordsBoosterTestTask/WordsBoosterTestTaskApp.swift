//
//  WordsBoosterTestTaskApp.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 16.06.2022.
//

import SwiftUI
import Combine

@main
struct WordsBoosterTestTaskApp: App {

    var diContainer = WBDIContainer()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                diContainer.animalCategoriesListView
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
