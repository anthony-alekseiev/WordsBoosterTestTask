//
//  AnimalCategory+Transform.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import Foundation

extension AnimalCategory {
    init(with networkItem: AnimalCategoriesService_GetCategoriesResponseCategory) {
        self.init(
            title: networkItem.title,
            description: networkItem.description,
            image: networkItem.image,
            order: networkItem.order,
            status: Status(with: networkItem.status),
            content: (networkItem.content ?? []).map { AnimalCategory.Content(with: $0) }
        )
    }
}

extension AnimalCategory.Status {
    init(with network: AnimalCategoriesService_GetCategoriesResponseCategory.Status) {
        switch network {
        case .paid: self = .paid
        case .free: self = .free
        }
    }
}

extension AnimalCategory.Content {
    init(with network: AnimalCategoriesService_GetCategoriesResponseCategory.Content) {
        self.init(
            fact: network.fact,
            image: network.image
        )
    }
}
