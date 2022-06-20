//
//  AnimalCategoryContent+Object.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 21.06.2022.
//

import Foundation

extension AnimalCategory.Content {
    init(with persistingObject: AnimalCategoryContentObject) {
        self.init(
            fact: persistingObject.fact,
            image: URL(string: persistingObject.image)!
        )
    }
}
