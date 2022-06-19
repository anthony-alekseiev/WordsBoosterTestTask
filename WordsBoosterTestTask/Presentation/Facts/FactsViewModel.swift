//
//  FactsViewModel.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 19.06.2022.
//

import Foundation
import Combine
import UIKit

class FactsViewModel: ObservableObject {
    
    var categoryTitle: String
    @Published var factItem: FactDisplayItem
    
    private var subscriptions = [AnyCancellable]()
    
    private var selectedContent: AnimalCategory.Content
    private var allFactItems: [FactDisplayItem]
    private var category: AnimalCategory
    private var imageLoader: ImageLoader
    
    init(category: AnimalCategory, imageLoader: ImageLoader) {
        self.category = category
        self.imageLoader = imageLoader
        
        self.categoryTitle = category.title
        self.selectedContent = category.content.first!
        self.allFactItems = category.content.enumerated().map { (i, singleContent) in
            let previousEnabled = i > 0
            let nextEnabled = i < category.content.count - 1
            return FactDisplayItem(
                id: singleContent.id,
                image: nil,
                isLoading: true,
                fact: singleContent.fact,
                previousEnabled: previousEnabled,
                nextEnabled: nextEnabled
            )
        }
        
        factItem = allFactItems.first!
    }
    
    func fetchData() {
        imageLoader.loadImages(for: category.content)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                self?.updateImage(result.image, for: result.source.id)
            }).store(in: &subscriptions)
    }
    
    private func updateImage(_ image: UIImage?,for contentId: String) {
        guard let idx = allFactItems.firstIndex(where: { $0.id == contentId }) else { return }
        allFactItems[idx].image = image
        allFactItems[idx].isLoading = false
        if factItem.id == allFactItems[idx].id {
            self.objectWillChange.send()
        }
    }
    
    func previousFact() {
        guard let idx = allFactItems.firstIndex(where: { $0.id == selectedContent.id }) else { return }
        let newIndex = idx - 1
        guard newIndex >= 0 else { return }
        factItem = allFactItems[newIndex]
        selectedContent = category.content[newIndex]
    }
    
    func nextFact() {
        guard let idx = allFactItems.firstIndex(where: { $0.id == selectedContent.id }) else { return }
        let newIndex = idx + 1
        guard newIndex <= allFactItems.count - 1 else { return }
        factItem = allFactItems[newIndex]
        selectedContent = category.content[newIndex]
    }
}
