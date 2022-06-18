//
//  AnimalCategoriesService.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 17.06.2022.
//

import Foundation
import Combine

protocol AnimalCategoriesService {
    func getCategories(request: AnimalCategoriesService_GetCategoriesRequest) ->
    AnyPublisher<AnimalCategoriesService_GetCategoriesResponse, AnimalCategoriesServiceError>
}
