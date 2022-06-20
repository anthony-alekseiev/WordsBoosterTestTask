//
//  AnimalCategoryObject.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 21.06.2022.
//

import Foundation
import Realm
import RealmSwift

class AnimalCategoryObject: Object {
    @Persisted(primaryKey: true) var id = ""
    @Persisted var title = ""
    @Persisted var _description: String = ""
    @Persisted var imageUrl: String = ""
    @Persisted var order: Int = -1
    @Persisted var status: String = ""
    @Persisted var content: List<AnimalCategoryContentObject>
}

extension AnimalCategoryObject {
    convenience init(with domain: AnimalCategory) {
        self.init()
        self.id = "\(domain.order)"
        self.title = domain.title
        self._description = domain.description
        self.imageUrl = domain.imageUrl.absoluteString
        self.order = domain.order
        self.status = domain.status.rawValue
        domain.content.forEach({ c in
            self.content.append(AnimalCategoryContentObject(with: c))
        })
        
    }
}
