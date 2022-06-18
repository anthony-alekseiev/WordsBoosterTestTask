//
//  AnimalCategoriesListDisplayItem.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import SwiftUI

class AnimalCategoriesListDisplayItem: Identifiable {
    enum State {
        case free
        case paid
        case comingSoon
    }
    
    var id: String
    var image: UIImage?
    var isLoading: Bool
    var title: String
    var subtitle: String
    var state: State
    
    init(
        id: String,
        image: UIImage?,
        isLoading: Bool,
        title: String,
        subtitle: String,
        state: State
    ) {
        self.id = id
        self.image = image
        self.isLoading = isLoading
        self.title = title
        self.subtitle = subtitle
        self.state = state
    }
}

extension AnimalCategoriesListDisplayItem {
    convenience init(with domain: AnimalCategory) {
        var state: AnimalCategoriesListDisplayItem.State = .free
        if domain.status == .paid {
            state = .paid
        }
        if domain.content.isEmpty {
            state = .comingSoon
        }
        
        self.init(
            id: String(domain.order),
            image: nil,
            isLoading: true,
            title: domain.title,
            subtitle: domain.description,
            state: state
        )
    }
}
