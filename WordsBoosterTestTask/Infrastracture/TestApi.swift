//
//  TestApi.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 17.06.2022.
//

import Foundation
import Combine

// The purpose of this class is just to test api call once

class TestApi {
    let api: AnimalCategoriesService
    var subscriptions: [AnyCancellable] = []
    
    init(api: AnimalCategoriesService) {
        self.api = api
    }
    
    
    func doTest() {
        api.getCategories(
            request: AnimalCategoriesService_GetCategoriesRequest()
        )
            .print("[NETWORK]")
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { value in
                print("VALUE: \(value)")
            }
            .store(in: &subscriptions)
    }
}
