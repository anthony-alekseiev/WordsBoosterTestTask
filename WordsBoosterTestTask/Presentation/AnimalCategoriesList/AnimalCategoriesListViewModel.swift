//
//  AnimalCategoriesListViewModel.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import SwiftUI
import Combine

final class AnimalCategoriesListViewModel: ObservableObject {
    
    @Published var error: Error?
    @Published var categoryItems = [AnimalCategoriesListDisplayItem]()
    
    private var categories: [AnimalCategory] = []
    private var subscriptions = [AnyCancellable]()
    private var imageLoader: ImageLoader
    private var categoriesService: AnimalCategoriesService
    
    init(
        imageLoader: ImageLoader,
        categoriesService: AnimalCategoriesService
    ) {
        self.imageLoader = imageLoader
        self.categoriesService = categoriesService
    }
 
    func fetchCategories() {
        guard categoryItems.isEmpty else { return }
        let request = AnimalCategoriesService_GetCategoriesRequest()
        categoriesService.getCategories(request: request)
            .map {
                $0.map { AnimalCategory(with: $0) }
            }.receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { [weak self] value in
                self?.categories = value
                self?.reloadItems()
            }
            .store(in: &subscriptions)
    }
    
    private func reloadItems() {
        categoryItems = categories
            .sorted(by: { $0.order < $1.order })
            .map { AnimalCategoriesListDisplayItem(with: $0) }
        imageLoader.loadImages(for: categories)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                self?.updateImage(result.image, for: result.source.id)
            }).store(in: &subscriptions)
    }
    
    private func updateImage(_ image: UIImage?,for categoryId: String) {
        let item = categoryItems.first(where: { $0.id == categoryId })
        item?.image = image
        item?.isLoading = false
        self.objectWillChange.send()
    }
}
