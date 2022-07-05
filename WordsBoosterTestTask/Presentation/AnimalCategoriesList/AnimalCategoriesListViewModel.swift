//
//  AnimalCategoriesListViewModel.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import SwiftUI
import Combine

enum AnimalCategoriesListAlertType {
    case error
    case adv
    case comingSoon
}

final class AnimalCategoriesListViewModel: ObservableObject {

    @Published var alertType: AnimalCategoriesListAlertType = .error
    @Published var shouldPresentAlert: Bool = false
    @Published var shouldPresentAdd: Bool = false
    @Published var shouldMoveToDetails: Bool = false

    @Published var isFetching: Bool = false
    @Published var error: Error?
    @Published var categoryItems = [AnimalCategoriesListDisplayItem]()
    @Published var selectedCategory: AnimalCategory?

    private var selectedId: String?
    private var categories: [AnimalCategory] = []
    private var subscriptions = [AnyCancellable]()
    private var timer: Timer?
    private var imageLoader: ImageLoader
    private var getAnimalCategoriesUseCase: GetAnimalCategories

    init(
        imageLoader: ImageLoader,
        getAnimalCategoriesUseCase: GetAnimalCategories
    ) {
        self.imageLoader = imageLoader
        self.getAnimalCategoriesUseCase = getAnimalCategoriesUseCase
    }

    func selectItem(with id: String) {
        guard let category = categories.first(where: { $0.id == id }) else { return }
        if category.content.isEmpty {
            alertType = .comingSoon
            shouldPresentAlert = true
            return
        }
        selectedCategory = category
        if category.status == .paid {
            alertType = .adv
            shouldPresentAlert = true
            selectedId = id
            return
        }
        shouldMoveToDetails = true
    }

    func didRequestToShowAd() {
        shouldPresentAdd = true
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] timer in
            self?.shouldPresentAdd = false
            self?.shouldMoveToDetails = true
            timer.invalidate()
            self?.timer = nil
        }

    }

    func fetchCategories() {
        guard categoryItems.isEmpty else { return }
        isFetching = true
        getAnimalCategoriesUseCase.execute(
            with: GetAnimalCategoriesRequest()
        )
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in

            if case .failure(let error) = completion {
                self?.alertType = .error
                self?.shouldPresentAlert = true
                self?.error = error
            }
        } receiveValue: { [weak self] value in
            self?.isFetching = value.isEmpty
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

    private func updateImage(_ image: UIImage?, for categoryId: String) {
        let item = categoryItems.first(where: { $0.id == categoryId })
        item?.image = image
        item?.isLoading = false
        self.objectWillChange.send()
    }
}
