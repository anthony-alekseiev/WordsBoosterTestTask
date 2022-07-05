//
//  ImageButtonOrEmpty.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 19.06.2022.
//

import SwiftUI

struct ImageButtonOrEmpty: View {
    var enabled: Bool
    var image: Image
    var action: () -> Void

    init(enabled: Bool, image: Image, _ action: @escaping () -> Void) {
        self.enabled = enabled
        self.image = image
        self.action = action
    }

    @ViewBuilder
    var body: some View {
        if enabled {
            Button {
                action()
            } label: {
                image
            }
        } else {
            EmptyView()
        }
    }
}
