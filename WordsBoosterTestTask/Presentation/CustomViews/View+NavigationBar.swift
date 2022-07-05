//
//  View+NavigationBarColor.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 19.06.2022.
//

import SwiftUI

extension View {

    func navigationStyle(
        _ backgroundColor: Color = .clear,
        barTintColor: Color = .white,
        applyShadow: Bool = false
    ) -> some View {
        self.modifier(
            NavigationBarModifier(
                backgroundColor: backgroundColor,
                barTintColor: barTintColor,
                shadowApplied: applyShadow
            )
        )
    }

}
