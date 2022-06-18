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
    
    let imageLoader: ImageLoader = WBImageLoader()
    let categoriesService: AnimalCategoriesService = AnimalCategoriesAPIClient()
    var animalCategoriesViewModel: AnimalCategoriesListViewModel {
        AnimalCategoriesListViewModel(
            imageLoader: imageLoader,
            categoriesService: categoriesService
        )
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AnimaCategoriesListView(viewModel: animalCategoriesViewModel)
            }
        }
    }
}
