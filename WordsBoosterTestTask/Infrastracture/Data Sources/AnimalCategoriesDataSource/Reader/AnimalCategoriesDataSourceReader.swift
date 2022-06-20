//
//  AnimalCategoriesDataSourceReader.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 20.06.2022.
//

import Foundation
import Combine

protocol AnimalCategoriesDataSourceReader {
    func getCategories(_ request: AnimalCategoriesDataSourceReaderRequest) -> AnyPublisher<[AnimalCategory], Error>
}
