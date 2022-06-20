//
//  AnimalCategoriesDataSourceImplementation.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 20.06.2022.
//

import Foundation
import Combine

extension AnimalCategoriesAPIClient: AnimalCategoriesDataSourceReader {
    func getCategories(_ request: AnimalCategoriesDataSourceReaderRequest) -> AnyPublisher<[AnimalCategory], Error> {
        let request = AnimalCategoriesEndpoint.getCategories.urlRequest
        return wrappedRequest(urlRequest: request)
            .map { (response: AnimalCategoriesService_GetCategoriesResponse) -> [AnimalCategory] in
                response.map { AnimalCategory(with: $0) }
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
