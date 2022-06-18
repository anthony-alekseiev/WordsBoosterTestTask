//
//  GetCategoriesResponse.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 17.06.2022.
//

import Foundation

typealias AnimalCategoriesService_GetCategoriesResponse = [AnimalCategoriesService_GetCategoriesResponseCategory]

struct AnimalCategoriesService_GetCategoriesResponseCategory: Decodable {
    enum Status: String, Decodable {
        case paid = "paid"
        case free = "free"
    }
    
    struct Content: Decodable {
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
