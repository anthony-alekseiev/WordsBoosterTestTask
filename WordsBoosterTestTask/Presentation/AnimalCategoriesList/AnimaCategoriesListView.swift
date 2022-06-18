//
//  AnimaCategoriesListView.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import SwiftUI

struct AnimaCategoriesListView: View {
    @Binding var items: [AnimalCategoriesListDisplayItem]
    
    var body: some View {
        ZStack {
            Color(red: 147/256, green: 91/256, blue: 191/256)
                .ignoresSafeArea()
            List($items) { item in
                AnimalCategoriesListRow(item: item)
                    .frame(height: 100)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        
    }
}

struct AnimaCategoriesListView_Previews: PreviewProvider {
    @State static var items = [
        AnimalCategoriesListDisplayItem(
            id: "1",
            image: nil,
            isLoading: false,
            title: "Dogs 🐕",
            subtitle: "Different facts about dogs",
            isPremium: true,
            isComingSoon: false
            
        ),
        AnimalCategoriesListDisplayItem(
            id: "2",
            image: nil,
            isLoading: true,
            title: "Cats 🐈",
            subtitle: "Different facts about cats",
            isPremium: false,
            isComingSoon: false
        ),
        AnimalCategoriesListDisplayItem(
            id: "3",
            image: nil,
            isLoading: false,
            title: "Pandas 🐼",
            subtitle: "Different facts about pandas",
            isPremium: false,
            isComingSoon: true
        )
    ]
    
    static var previews: some View {
        AnimaCategoriesListView(items: $items)
    }
}
