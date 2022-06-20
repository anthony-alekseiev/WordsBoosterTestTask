//
//  AnimalCategoryDataSourceWriter.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 20.06.2022.
//

import Foundation

protocol AnimalCategoriesDataSourceWriter {
    func saveMultiple(with request: AnimalCategoriesDataSourceWriterSaveMultipleRequest)
}
