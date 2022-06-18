//
//  AnimalCategoriesListRow.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import SwiftUI

class AnimalCategoriesListDisplayItem {
    var id: String
    var image: UIImage?
    var isLoading: Bool
    var title: String
    var subtitle: String
    var isPremium: Bool
    var isComingSoon: Bool
    
    init(
        id: String,
        image: UIImage?,
        isLoading: Bool,
        title: String,
        subtitle: String,
        isPremium: Bool,
        isComingSoon: Bool
    ) {
        self.id = id
        self.image = image
        self.isLoading = isLoading
        self.title = title
        self.subtitle = subtitle
        self.isPremium = isPremium
        self.isComingSoon = isComingSoon
    }
}

struct AnimalCategoriesListRow: View {
    
    @Binding var item: AnimalCategoriesListDisplayItem
    
    var body: some View {
        ZStack {
            cardView
            mainContent
        }
        .overlay(comingSoonOverlay)
        .cornerRadius(6)
            
    }
    
    private var cardView: some View {
        Rectangle()
            .fill(Color.white)
            .shadow(
                color: .black.opacity(0.2),
                radius: 2, x: 0, y: 2
            )
    }
    
    @ViewBuilder private var mainContent: some View {
        GeometryReader { (geometry : GeometryProxy) in
            HStack(alignment: .top, spacing: 12) {
                LoadingImageView(
                    image: $item.image,
                    isLoading: $item.isLoading
                )
                    .frame(
                        width: geometry.size.width * 0.36,
                        height: geometry.size.height
                    )
                    .clipped()
                VStack(alignment: .leading) {
                    Spacer()
                    Text(item.title)
                        .font(
                            .custom(
                                "Basic",
                                size: 16
                            )
                            .weight(.regular)
                        )
                        .foregroundColor(.black)
                    Text(item.subtitle)
                        .font(
                            .custom(
                                "Basic",
                                size: 12
                            )
                            .weight(.regular)
                        )
                        .foregroundColor(.black.opacity(0.5))
                    Spacer()
                    Spacer()
                    if item.isPremium {
                        PremiumView()
                    }
                }
                Spacer()
            }
            
        }
        .padding([.top, .bottom], 5)
        .padding([.trailing, .leading], 10)
    }
    
    @ViewBuilder private var comingSoonOverlay: some View {
        if item.isComingSoon {
                ZStack {
                    Color(.black.withAlphaComponent(0.6))
                    HStack {
                        Spacer()
                        Spacer()
                        Image("coming-soon")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
}

struct AnimalCategoriesListRow_Previews: PreviewProvider {
    @State static var premiumItem = AnimalCategoriesListDisplayItem(
        id: "1",
        image: nil,
        isLoading: false,
        title: "Dogs 🐕",
        subtitle: "Different facts about dogs",
        isPremium: true,
        isComingSoon: false
        
    )
    @State static var freeItem = AnimalCategoriesListDisplayItem(
        id: "2",
        image: nil,
        isLoading: true,
        title: "Cats 🐈",
        subtitle: "Different facts about cats",
        isPremium: false,
        isComingSoon: false
    )
    
    @State static var noContentItem = AnimalCategoriesListDisplayItem(
        id: "3",
        image: nil,
        isLoading: false,
        title: "Pandas 🐼",
        subtitle: "Different facts about pandas",
        isPremium: false,
        isComingSoon: true
    )
    
    static var previews: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 147/256, green: 91/256, blue: 191/256))
            VStack(spacing: 20) {
                AnimalCategoriesListRow(item: $premiumItem)
                    .padding([.leading, .trailing], 20)
                    .frame(height: 100)
                AnimalCategoriesListRow(item: $freeItem)
                    .padding([.leading, .trailing], 20)
                    .frame(height: 100)
                AnimalCategoriesListRow(item: $noContentItem)
                    .padding([.leading, .trailing], 20)
                    .frame(height: 100)
            }
        }
        .previewDevice("iPhone 13")
    }
}
