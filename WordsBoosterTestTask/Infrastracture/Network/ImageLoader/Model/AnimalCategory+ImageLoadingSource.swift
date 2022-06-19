//
//  AnimalCategory+ImageLoadingSource.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import Foundation

extension AnimalCategory: ImageLoadingSource {
    
    var id: String {
        return String(self.order)
    }
    
    var imageUrl: URL {
        return self.image
    }
}

extension AnimalCategory.Content: ImageLoadingSource {
    
    var id: String {
        return self.fact + self.image.absoluteString
    }

    var imageUrl: URL {
        return self.image
    }
}
