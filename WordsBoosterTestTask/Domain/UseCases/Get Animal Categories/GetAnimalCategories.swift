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
    
    private var repository: AnimalCategoriesRepositoryProtocol
    
    init(repository: AnimalCategoriesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(with request: GetAnimalCategoriesRequest) -> AnyPublisher<[AnimalCategory], Error> {
        let request = AnimalCategoriesRepositoryGetRequest()        
        return repository.getAnimalCategories(request)
            .eraseToAnyPublisher()
        
    }
    
}
