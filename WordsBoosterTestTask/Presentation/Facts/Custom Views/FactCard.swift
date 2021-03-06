//
//  FactCard.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 19.06.2022.
//

import SwiftUI

struct FactCard: View {

    @State private var translation: CGSize = .zero
    @Binding var item: FactDisplayItem

    var previousAction: () -> Void
    var nextAction: () -> Void

    var body: some View {
        ZStack {
            cardView
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 14) {
                    imageView(geometry: geometry)
                    factTextView
                    Spacer()
                    selectorView
                }
                .padding(20)
            }
        }
        .cornerRadius(6)
        .shadow(
            color: .black.opacity(0.3),
            radius: 60, x: 0, y: 20
        )
    }

    private var cardView: some View {
        Rectangle()
            .fill(Color.white)
    }

    private var factTextView: some View {
        Text(item.fact)
            .minimumScaleFactor(0.5)
            .font(
                .custom(
                    "Basic",
                    size: 18
                )
            .weight(.regular)
        )
        .foregroundColor(.black)
    }

    @ViewBuilder
    private var selectorView: some View {
        HStack {
            ImageButtonOrEmpty(
                enabled: item.previousEnabled,
                image: Image("previous"),
                previousAction
            )
            Spacer()
            ImageButtonOrEmpty(
                enabled: item.nextEnabled,
                image: Image("next"),
                nextAction
            )
        }
    }

    private func imageView(geometry: GeometryProxy) -> some View {
        LoadingImageView(
            image: $item.image,
            isLoading: $item.isLoading
        )
        .frame(
            width: geometry.size.width * 0.9,
            height: geometry.size.height * 0.55
        )
        .clipped()
    }
}

struct FactCard_Previews: PreviewProvider {
    @State static var item = FactDisplayItem(
        id: "1",
        image: nil,
        isLoading: false,
        fact: "Different facts about pandas",
        previousEnabled: true,
        nextEnabled: true
    )

    static var previews: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 147/256, green: 91/256, blue: 191/256))
            FactCard(item: $item, previousAction: {

            }, nextAction: {

            })
                .frame(height: 435)
                .padding(.horizontal, 20)

        }

    }
}
