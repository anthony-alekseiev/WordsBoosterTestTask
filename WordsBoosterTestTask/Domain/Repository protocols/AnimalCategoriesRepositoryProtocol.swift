//
//  AnimalCategoriesRepositoryProtocol.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 20.06.2022.
//

import Foundation
import Combine

protocol AnimalCategoriesRepositoryProtocol {
    func getAnimalCategories(_ request: AnimalCategoriesRepositoryGetRequest) -> AnyPublisher<[AnimalCategory], Error>
}
