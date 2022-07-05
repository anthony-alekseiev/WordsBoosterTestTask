//
//  WBImageLoader.swift
//  likekoteeky
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import SwiftUI
import Combine

struct WBImageLoader: ImageLoader {

    init() {

    }

    func loadImages(for source: [ImageLoadingSource]) -> AnyPublisher<ImageLoadingResult, Never> {
        source
            .publisher
            .flatMap {
                loadImage(for: $0)
            }
            .eraseToAnyPublisher()

    }

    private func loadImage(for source: ImageLoadingSource) -> AnyPublisher<ImageLoadingResult, Never> {
        URLSession.shared
            .dataTaskPublisher(for: source.imageUrl)
            .replaceError(with: (Data(), URLResponse.init()))
            .map {
                ImageLoadingResult(
                    image: UIImage(data: $0.data),
                    source: source
                )
            }
            .eraseToAnyPublisher()
    }
}
