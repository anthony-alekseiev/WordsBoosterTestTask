//
//  FakeAnimalCategoriesService.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import Foundation
import Combine

struct FakeAnimalCategoriesService: AnimalCategoriesService {
    let publisher = PassthroughSubject<AnimalCategoriesService_GetCategoriesResponse, AnimalCategoriesServiceError>()
    var response: AnimalCategoriesService_GetCategoriesResponse
    var error: AnimalCategoriesServiceError?
    
    init(
        expectedResponse: AnimalCategoriesService_GetCategoriesResponse = [],
        expectedError: AnimalCategoriesServiceError? = nil
    ) {
        self.response = expectedResponse
    }
    
    func getCategories(request: AnimalCategoriesService_GetCategoriesRequest) -> AnyPublisher<AnimalCategoriesService_GetCategoriesResponse, AnimalCategoriesServiceError> {
        if let error = error {
            publisher.send(completion: .failure(error))
        } else {
            publisher.send(response)
        }
        return publisher.eraseToAnyPublisher()
    }
    
}
