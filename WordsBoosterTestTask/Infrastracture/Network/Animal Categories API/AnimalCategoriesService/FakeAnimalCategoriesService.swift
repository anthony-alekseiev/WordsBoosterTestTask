//
//  FakeAnimalCategoriesService.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import Foundation
import Combine

struct FakeAnimalCategoriesService: AnimalCategoriesService {
    let publisher = PassthroughSubject<AnimalCategoriesServiceGetResponse, AnimalCategoriesServiceError>()
    var response: AnimalCategoriesServiceGetResponse
    var error: AnimalCategoriesServiceError?

    init(
        expectedResponse: AnimalCategoriesServiceGetResponse = [],
        expectedError: AnimalCategoriesServiceError? = nil
    ) {
        self.response = expectedResponse
    }

    func getCategories(
        request: AnimalCategoriesServiceGetRequest
    ) -> AnyPublisher<AnimalCategoriesServiceGetResponse, AnimalCategoriesServiceError> {
        if let error = error {
            publisher.send(completion: .failure(error))
        } else {
            publisher.send(response)
        }
        return publisher.eraseToAnyPublisher()
    }

}
