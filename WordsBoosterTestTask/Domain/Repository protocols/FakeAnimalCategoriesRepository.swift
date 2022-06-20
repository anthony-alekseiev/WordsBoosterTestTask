//
//  FakeAnimalCategoriesRepository.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 20.06.2022.
//

import Foundation
import Combine

struct FakeAnimalCategoriesRepository: AnimalCategoriesRepositoryProtocol {
    
    private var categroies: [AnimalCategory] = [AnimalCategory]()
    private var error: Error? = nil
    
    private var subject = PassthroughSubject<[AnimalCategory], Error>()
    
    func getAnimalCategories(_ request: AnimalCategoriesRepositoryGetRequest) -> AnyPublisher<[AnimalCategory], Error> {
        if let error = error {
            subject.send(completion: .failure(error))
        } else {
            subject.send(categroies)
        }
        return subject.eraseToAnyPublisher()
    }
}
