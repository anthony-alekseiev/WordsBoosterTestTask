//
//  GetAnimalCategories.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 20.06.2022.
//

import Foundation
import Combine

struct GetAnimalCategories: UseCase {
    
    typealias Request = GetAnimalCategoriesRequest
    typealias Response = [AnimalCategory]
    
    private var subscriptions = [AnyCancellable]()
    private var categoriesService: AnimalCategoriesService
    
    init(categoriesService: AnimalCategoriesService) {
        self.categoriesService = categoriesService
    }
    
    func execute(with request: GetAnimalCategoriesRequest) -> AnyPublisher<[AnimalCategory], Error> {
        let request = AnimalCategoriesService_GetCategoriesRequest()
        return categoriesService.getCategories(request: request)
            .map {
                $0.map { AnimalCategory(with: $0) }
            }
            .mapError({ err in
                err as Error
            })
            .eraseToAnyPublisher()
        
    }
    
}
