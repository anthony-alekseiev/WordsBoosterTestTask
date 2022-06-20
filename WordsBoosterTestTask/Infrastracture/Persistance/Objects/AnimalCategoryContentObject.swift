//
//  AnimalCategoryContentObject.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 21.06.2022.
//

import Foundation
import RealmSwift

class AnimalCategoryContentObject: EmbeddedObject {
    @Persisted var fact: String
    @Persisted var image: String
}

extension AnimalCategoryContentObject {
    convenience init(with domain: AnimalCategory.Content) {
        self.init()
        self.fact = domain.fact
        self.image = domain.imageUrl.absoluteString
    }
}
