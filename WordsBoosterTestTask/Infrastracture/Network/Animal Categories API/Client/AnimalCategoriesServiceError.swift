//
//  AnimalCategoriesServiceError.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 17.06.2022.
//

import Foundation

enum AnimalCategoriesServiceError: LocalizedError {
    case serverError
    case clientError
    case parsingError
    case unknownError(msg: String)

    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Something went wrong"
        case .clientError:
            return "Invalid request"
        case .parsingError:
            return "Invalid response"
        case .unknownError(let msg):
            return msg
        }
    }
}
