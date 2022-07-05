//
//  AnimalCategoriesAPIClient.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 17.06.2022.
//

import Foundation
import Combine

class AnimalCategoriesAPIClient {
    let apiSession = URLSession.shared

    func wrappedRequest<Response: Decodable>(
        urlRequest: AnimalCategoriesURLRequest
    ) -> AnyPublisher<Response, AnimalCategoriesServiceError> {
        return apiSession
            .dataTaskPublisher(for: urlRequest.urlSessionRequest)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .mapError { error -> AnimalCategoriesServiceError in
                if let err = error as? URLError {
                    if 400..<500 ~= err.errorCode {
                        return .clientError
                    }
                    if err.errorCode > 500 {
                        return .serverError
                    }
                }
                if let err = error as? DecodingError {
                    print(err.localizedDescription)
                    return .parsingError
                }
                return .unknownError(msg: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
