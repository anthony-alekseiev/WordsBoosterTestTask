//
//  AnimalCategory.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import Foundation

struct AnimalCategory {
    enum Status {
        case paid
        case free
    }
    
    struct Content {
        var fact: String
        var image: URL
    }
    
    var title: String
    var description: String
    var image: URL
    var order: Int
    var status: Status
    var content: [Content]?
}
