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
    let apiClient = AnimalCategoriesAPIClient()
    var dataProvider: DataProvider = {
        let p = DataProvider()
        p.configure()
        return p
    }()
    var remoteDataSource: AnimalCategoriesDataSourceReader { apiClient }
    var localDataSource: (AnimalCategoriesDataSourceReader & AnimalCategoriesDataSourceWriter) {
        AnimalCategoryStorage(provider: dataProvider)
    }
    
    var animalCategoriesRespository: AnimalCategoriesRepositoryProtocol {
        AnimalCategoriesRepository(
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource
        )
    }
    
    var getAnimalCategoriesUseCase: GetAnimalCategories {
        GetAnimalCategories(repository: animalCategoriesRespository)
    }
    
    var animalCategoriesViewModel: AnimalCategoriesListViewModel {
        AnimalCategoriesListViewModel(
            imageLoader: imageLoader,
            getAnimalCategoriesUseCase: getAnimalCategoriesUseCase
        )
    }
    
    func buildFactsViewModel(_ category: AnimalCategory) -> FactsViewModel {
        FactsViewModel(category: category, imageLoader: imageLoader)
    }
    
    func buildFactsView(_ animalCategory: AnimalCategory) -> FactsView {
        FactsView(viewModel: buildFactsViewModel(animalCategory))
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AnimaCategoriesListView(
                    viewModel: animalCategoriesViewModel,
                    detailsViewBuilder: buildFactsView)
            }
            .navigationViewStyle(StackNavigationViewStyle())    
        }
    }
}
