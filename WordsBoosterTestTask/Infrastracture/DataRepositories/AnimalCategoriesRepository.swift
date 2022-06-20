//
//  AnimalCategoriesRepository.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 20.06.2022.
//

import Foundation
import Combine

class AnimalCategoriesRepository {
    let localDataSource: (AnimalCategoriesDataSourceReader & AnimalCategoriesDataSourceWriter)
    let remoteDataSource: AnimalCategoriesDataSourceReader
    
    let subject = PassthroughSubject<[AnimalCategory], Error>()
    var store = [AnyCancellable]()
    
    init(
        localDataSource: (AnimalCategoriesDataSourceReader & AnimalCategoriesDataSourceWriter),
        remoteDataSource: AnimalCategoriesDataSourceReader
    ) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
}

extension AnimalCategoriesRepository: AnimalCategoriesRepositoryProtocol {
    func getAnimalCategories(_ request: AnimalCategoriesRepositoryGetRequest) -> AnyPublisher<[AnimalCategory], Error> {
        let localPublisher = localDataSource.getCategories(AnimalCategoriesDataSourceReaderRequest())
        remoteDataSource.getCategories(AnimalCategoriesDataSourceReaderRequest())
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.subject.send(completion: .failure(error))
                }
            } receiveValue: { [weak self] result in
                self?.localDataSource.saveMultiple(
                    with: AnimalCategoriesDataSourceWriterSaveMultipleRequest(
                        categories: result
                    )
                )
            }
            .store(in: &store)
        return localPublisher.merge(with: subject).eraseToAnyPublisher()
    }
}
