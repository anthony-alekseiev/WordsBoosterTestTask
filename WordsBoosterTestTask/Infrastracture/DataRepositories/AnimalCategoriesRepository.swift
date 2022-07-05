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
    func saveRemoteToLacal(_ remote: [AnimalCategory]) {
        do {
            try localDataSource.saveMultiple(
                with: AnimalCategoriesDataSourceSaveRequest(
                    categories: remote
                )
            )
        } catch {
            print("Error while saving remote animal categories to local storage. Reason: \(error.localizedDescription)")
        }
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
                self?.saveRemoteToLacal(result)
            }
            .store(in: &store)
        return localPublisher.merge(with: subject).eraseToAnyPublisher()
    }
}
