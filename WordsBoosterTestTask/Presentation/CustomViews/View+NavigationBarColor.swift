//
//  View+NavigationBarColor.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 19.06.2022.
//

import SwiftUI

extension View {
 
    func navigationBarColor(_ backgroundColor: Color = .clear) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}
