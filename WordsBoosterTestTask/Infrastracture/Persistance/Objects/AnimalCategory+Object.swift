//
//  AnimalCategory+Object.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 21.06.2022.
//

import Foundation

extension AnimalCategory {
    init(with persistingObject: AnimalCategoryObject) {
        self.init(
            title: persistingObject.title,
            description: persistingObject.details,
            image: URL(string: persistingObject.imageUrl)!,
            order: persistingObject.order,
            status: Status(rawValue: persistingObject.status) ?? .unknown,
            content: persistingObject.content.map {
                AnimalCategory.Content(with: $0)
            }
        )
    }
}
