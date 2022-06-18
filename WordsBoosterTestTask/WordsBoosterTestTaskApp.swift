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
    
    let apiClient: AnimalCategoriesService = AnimalCategoriesAPIClient()
    var apiTester: TestApi { TestApi(api: apiClient) }
    
    var body: some Scene {
        WindowGroup {
            ContentView(apiTester: apiTester)
        }
    }
}
