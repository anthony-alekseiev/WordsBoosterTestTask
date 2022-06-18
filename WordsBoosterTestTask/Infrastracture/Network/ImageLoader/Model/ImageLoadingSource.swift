//
//  ImageLoadingSource.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import Foundation

protocol ImageLoadingSource {
    var id: String { get }
    var imageUrl: URL { get }
}
