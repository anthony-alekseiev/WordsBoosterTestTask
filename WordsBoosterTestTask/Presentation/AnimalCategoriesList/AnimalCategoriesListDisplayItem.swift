//
//  AnimalCategoriesListDisplayItem.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import SwiftUI

class AnimalCategoriesListDisplayItem: Identifiable {
    var id: String
    var image: UIImage?
    var isLoading: Bool
    var title: String
    var subtitle: String
    var isPremium: Bool
    var isComingSoon: Bool
    
    init(
        id: String,
        image: UIImage?,
        isLoading: Bool,
        title: String,
        subtitle: String,
        isPremium: Bool,
        isComingSoon: Bool
    ) {
        self.id = id
        self.image = image
        self.isLoading = isLoading
        self.title = title
        self.subtitle = subtitle
        self.isPremium = isPremium
        self.isComingSoon = isComingSoon
    }
}
