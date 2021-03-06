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
                TabView(selection: $viewModel.selectedItemId) {
                    ForEach($viewModel.allFactItems) { item in
                        FactCard(
                            item: item,
                            previousAction: viewModel.previousFact,
                            nextAction: viewModel.nextFact
                        )
                        .frame(maxHeight: geometry.size.height * 0.7)
                        .padding(.horizontal, 20)
                        .tag(item.id)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: viewModel.selectedItemId)
                .transition(.slide)
                .ignoresSafeArea(.container, edges: .bottom)
            }
            .navigationStyle(
                Color(red: 147/256, green: 91/256, blue: 191/256),
                barTintColor: .black,
                applyShadow: true
            )
            .navigationTitle(viewModel.categoryTitle)
        }.onAppear {
            viewModel.fetchData()
        }
    }
}

struct FactsView_Previews: PreviewProvider {
    static var factOne: AnimalCategory.Content {
        let factDetails = "During the Renaissance, detailed portraits of the dog as a symbol of fidelity and loyalty appeared in mythological, allegorical, and religious art throughout Europe"
        let factDetailsContinuation = ", including works by Leonardo da Vinci, Diego Velázquez, Jan van Eyck, and Albrecht Durer."
        return AnimalCategory.Content(
            fact: factDetails + factDetailsContinuation,
            image: URL(string: "https://images.dog.ceo/breeds/basenji/n02110806_4150.jpg")!
        )
    }
    static var factTwo: AnimalCategory.Content {
        AnimalCategory.Content(
            fact: "The Mayans and Aztecs symbolized every tenth day with the dog, and those born under this sign were believed to have outstanding leadership skills.",
            image: URL(string: "https://images.dog.ceo/breeds/cotondetulear/100_2397.jpgt")!
        )
    }
    static var factThree: AnimalCategory.Content {
        AnimalCategory.Content(
            fact: "If never spayed or neutered, a female dog, her mate, and their puppies could produce over 66,000 dogs in 6 years!",
            image: URL(string: "https://images.dog.ceo/breeds/puggle/IMG_075427.jpg")!
        )
    }
    static var allFacts: [AnimalCategory.Content] {
        [factOne, factTwo, factThree]
    }
    @State static var viewModel = FactsViewModel(
        category: AnimalCategory(
            title: "Dogs 🐕",
            description: "Different facts about dogs",
            image: URL(string: "https://google.com")!,
            order: 1,
            status: .free,
            content: allFacts
        ), imageLoader: FakeImageLoader()
    )

    static var previews: some View {
        NavigationView {
            FactsView(viewModel: viewModel)
        }

    }
}
