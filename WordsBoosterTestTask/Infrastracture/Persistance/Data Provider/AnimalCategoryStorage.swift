//
//  AnimalCategoryStorage.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 21.06.2022.
//

import Foundation
import Combine

struct AnimalCategoryStorage {
    let provider: DataProvider

    init(provider: DataProvider) {
        self.provider = provider
    }
}

extension AnimalCategoryStorage: AnimalCategoriesDataSourceReader {
    func getCategories(_ request: AnimalCategoriesDataSourceReaderRequest) -> AnyPublisher<[AnimalCategory], Error> {
        return provider.objects(AnimalCategoryObject.self)
            .map {
                $0.map { AnimalCategory(with: $0) }
            }
            .eraseToAnyPublisher()
    }
}

extension AnimalCategoryStorage: AnimalCategoriesDataSourceWriter {
    func saveMultiple(with request: AnimalCategoriesDataSourceSaveRequest) throws {
        try self.provider.add(
            request.categories.map { AnimalCategoryObject(with: $0) }
        )
    }
}
