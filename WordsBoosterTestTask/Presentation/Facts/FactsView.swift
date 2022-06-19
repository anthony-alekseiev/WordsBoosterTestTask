//
//  FactsView.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 19.06.2022.
//

import SwiftUI

struct FactsView: View {
    @ObservedObject var viewModel: FactsViewModel
    
    var body: some View {
        ZStack {
            Color(red: 147/256, green: 91/256, blue: 191/256)
                .ignoresSafeArea()
            GeometryReader { geometry in
                FactCard(
                    item: $viewModel.factItem,
                    previousAction: viewModel.previousFact,
                    nextAction: viewModel.nextFact
                )
                    .frame(height: geometry.size.height * 0.62)
                    .padding(.horizontal, 20)
                    .navigationStyle(
                        Color(red: 147/256, green: 91/256, blue: 191/256),
                        barTintColor: .black,
                        applyShadow: true
                    )
                    .navigationTitle(viewModel.categoryTitle)
            }
        }.onAppear {
            viewModel.fetchData()
        }
    }
}

struct FactsView_Previews: PreviewProvider {
    @State static var viewModel = FactsViewModel(
        category: AnimalCategory(
            title: "Dogs 🐕",
            description: "Different facts about dogs",
            image: URL(string: "https://google.com")!,
            order: 1,
            status: .free,
            content: [
                AnimalCategory.Content(
                    fact: "During the Renaissance, detailed portraits of the dog as a symbol of fidelity and loyalty appeared in mythological, allegorical, and religious art throughout Europe, including works by Leonardo da Vinci, Diego Velázquez, Jan van Eyck, and Albrecht Durer.",
                    image: URL(string: "https://images.dog.ceo/breeds/basenji/n02110806_4150.jpg")!
                ),
                AnimalCategory.Content(
                    fact: "The Mayans and Aztecs symbolized every tenth day with the dog, and those born under this sign were believed to have outstanding leadership skills.",
                    image: URL(string: "https://images.dog.ceo/breeds/cotondetulear/100_2397.jpgt")!
                ),
                AnimalCategory.Content(
                    fact: "If never spayed or neutered, a female dog, her mate, and their puppies could produce over 66,000 dogs in 6 years!",
                    image: URL(string: "https://images.dog.ceo/breeds/puggle/IMG_075427.jpg")!
                )
            ]
        ), imageLoader: FakeImageLoader()
    )
    
    static var previews: some View {
        NavigationView {
            FactsView(viewModel: viewModel)
        }
        
    }
}
