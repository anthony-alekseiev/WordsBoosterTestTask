//
//  PremiumView.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import SwiftUI

struct PremiumView: View {
    var body: some View {
        HStack {
            Image("premium_lock")
            Text("Premium")
                .font(
                    .custom(
                        "Basic",
                        size: 16
                    )
                    .weight(.regular)
                )
                .foregroundColor(
                    Color(
                        red: 8/256,
                        green: 58/256,
                        blue: 235/256
                    )
                )
        }
    }
}

struct PremiumView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumView()
    }
}
