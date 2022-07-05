//
//  GetCategoriesResponse.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 17.06.2022.
//

import Foundation

typealias AnimalCategoriesServiceGetResponse = [AnimalCategoriesServiceGetResponseUnit]

struct AnimalCategoriesServiceGetResponseUnit: Decodable {
    enum Status: String, Decodable {
        case paid
        case free
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
