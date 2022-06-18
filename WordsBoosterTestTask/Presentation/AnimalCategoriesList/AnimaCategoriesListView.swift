//
//  AnimaCategoriesListView.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import SwiftUI

struct AnimaCategoriesListView: View {
    @ObservedObject var viewModel: AnimalCategoriesListViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 147/256, green: 91/256, blue: 191/256)
                    .ignoresSafeArea()
                List($viewModel.categoryItems) { item in
                    AnimalCategoriesListRow(item: item)
                        .frame(height: geometry.size.height * 0.14)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }.onAppear {
            viewModel.fetchCategories()
        }
    }
}

struct AnimaCategoriesListView_Previews: PreviewProvider {
    @State static var viewModel = AnimalCategoriesListViewModel(
        imageLoader: FakeImageLoader(),
        categoriesService: FakeAnimalCategoriesService()
    )
    
    static var previews: some View {
        viewModel.categoryItems = [
            AnimalCategoriesListDisplayItem(
                id: "1",
                image: nil,
                isLoading: false,
                title: "Dogs 🐕",
                subtitle: "Different facts about dogs",
                state: .paid
                
            ),
            AnimalCategoriesListDisplayItem(
                id: "2",
                image: nil,
                isLoading: true,
                title: "Cats 🐈",
                subtitle: "Different facts about cats",
                state: .free
            ),
            AnimalCategoriesListDisplayItem(
                id: "3",
                image: nil,
                isLoading: false,
                title: "Pandas 🐼",
                subtitle: "Different facts about pandas",
                state: .comingSoon
            )
        ]
        return AnimaCategoriesListView(viewModel: viewModel)
    }
}
