//
//  DI.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 21.06.2022.
//

import Foundation

class WBDIContainer {
    let imageLoader: ImageLoader = WBImageLoader()
    let apiClient = AnimalCategoriesAPIClient()
    var dataProvider: DataProvider = {
        let provider = DataProvider()
        provider.configure()
        return provider
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

    var animalCategoriesListView: AnimaCategoriesListView {
        AnimaCategoriesListView(
            viewModel: animalCategoriesViewModel,
            detailsViewBuilder: buildFactsView)
    }

    func buildFactsViewModel(_ category: AnimalCategory) -> FactsViewModel {
        FactsViewModel(category: category, imageLoader: imageLoader)
    }

    func buildFactsView(_ animalCategory: AnimalCategory) -> FactsView {
        FactsView(viewModel: buildFactsViewModel(animalCategory))
    }
}
