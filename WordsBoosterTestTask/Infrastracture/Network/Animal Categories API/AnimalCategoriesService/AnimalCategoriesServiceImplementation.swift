//
//  AnimalCategoriesServiceImplementation.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 17.06.2022.
//

import Foundation
import Combine

extension AnimalCategoriesAPIClient: AnimalCategoriesService {
    func getCategories(request: AnimalCategoriesServiceGetRequest) ->
    AnyPublisher<AnimalCategoriesServiceGetResponse, AnimalCategoriesServiceError> {
        let request = AnimalCategoriesEndpoint.getCategories.urlRequest
        return wrappedRequest(urlRequest: request)
    }
}
