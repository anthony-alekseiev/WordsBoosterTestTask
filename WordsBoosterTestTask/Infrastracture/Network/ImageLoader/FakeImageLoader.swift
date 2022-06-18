//
//  FakeImageLoader.swift
//  likekoteeky
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import Foundation
import Combine

struct FakeImageLoader: ImageLoader {
    let publisher = PassthroughSubject<ImageLoadingResult, Never>()
    var images = [ImageLoadingResult]()
    
    init(images: [ImageLoadingResult]=[]) {
        self.images = images
    }
    
    func loadImages(for source: [ImageLoadingSource]) -> AnyPublisher<ImageLoadingResult, Never> {
        images.forEach { publisher.send($0) }
        return publisher.eraseToAnyPublisher()
    }
}
