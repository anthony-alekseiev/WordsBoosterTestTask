//
//  AnimalCategoriesEndpoint.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 16.06.2022.
//

import Foundation

enum AnimalCategoriesEndpoint {
    static let baseURLString = "https://drive.google.com/uc?export=download&id=12L7OflAsIxPOF47ssRdKyjXoWbUrq4V5"

    case getCategories

    var urlRequest: AnimalCategoriesURLRequest {
        switch self {
        case .getCategories:
            let url = URL(string: AnimalCategoriesEndpoint.baseURLString)!
            let request = URLRequest(
                url: url,
                cachePolicy: .reloadIgnoringLocalCacheData,
                timeoutInterval: 10
                )
            return AnimalCategoriesURLRequest(urlSessionRequest: request)
        }
    }

}
