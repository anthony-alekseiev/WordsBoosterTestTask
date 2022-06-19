//
//  FactDisplayItem.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 19.06.2022.
//

import SwiftUI

class FactDisplayItem {
    var image: UIImage?
    var isLoading: Bool
    var fact: String
    var previousEnabled: Bool
    var nextEnabled: Bool
    
    init(
        image: UIImage?,
        isLoading: Bool,
        fact: String,
        previousEnabled: Bool,
        nextEnabled: Bool
    ) {
        self.image = image
        self.isLoading = isLoading
        self.fact = fact
        self.previousEnabled = previousEnabled
        self.nextEnabled = nextEnabled
    }
}
