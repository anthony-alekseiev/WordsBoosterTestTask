//
//  UseCase.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 20.06.2022.
//

import Foundation
import Combine

protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(with request: Request) -> AnyPublisher<Response, Error>
}
