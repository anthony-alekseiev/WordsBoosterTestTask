//
//  FactDisplayItem.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 19.06.2022.
//

import SwiftUI

class FactDisplayItem: Identifiable, Hashable {

    var id: String
    var image: UIImage?
    var isLoading: Bool
    var fact: String
    var previousEnabled: Bool
    var nextEnabled: Bool

    init(
        id: String,
        image: UIImage?,
        isLoading: Bool,
        fact: String,
        previousEnabled: Bool,
        nextEnabled: Bool
    ) {
        self.id = id
        self.image = image
        self.isLoading = isLoading
        self.fact = fact
        self.previousEnabled = previousEnabled
        self.nextEnabled = nextEnabled
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: FactDisplayItem, rhs: FactDisplayItem) -> Bool {
        lhs.id == rhs.id && lhs.image == rhs.image
    }
}
