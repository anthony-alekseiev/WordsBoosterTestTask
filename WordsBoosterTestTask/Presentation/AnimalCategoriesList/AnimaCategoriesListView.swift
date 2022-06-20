//
//  AnimaCategoriesListView.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import SwiftUI

struct AnimaCategoriesListView: View {
    @ObservedObject var viewModel: AnimalCategoriesListViewModel
    var detailsViewBuilder: (_ animalCategory: AnimalCategory) -> FactsView
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                nextScreenNavigationLink
                Color(red: 147/256, green: 91/256, blue: 191/256)
                    .ignoresSafeArea()
                if viewModel.isFetching {
                    ProgressView("Loading categories...")
                        .tint(.white)
                        .foregroundColor(.white)
                } else if viewModel.shouldPresentAdd {
                    ProgressView()
                        .tint(.white)
                        .foregroundColor(.white)
                } else {
                    categoriesList(geometry: geometry)
                }
            }
            

        }
        .alert(isPresented: $viewModel.shouldPresentAlert) {
            switch viewModel.alertType {
            case .error:
                return errorAlert
            case .comingSoon:
                return comingSoonAlert
            case .ad:
                return showAddAlert
            }
        }
        .onAppear {
            viewModel.fetchCategories()
        }
        .navigationBarHidden(true)
        .navigationBarTitle(Text(""))
    }
    
    @ViewBuilder
    private var nextScreenNavigationLink: some View {
        NavigationLink(
            isActive: $viewModel.shouldMoveToDetails) {
                if viewModel.shouldMoveToDetails {
                    if viewModel.selectedCategory != nil {
                        detailsViewBuilder(viewModel.selectedCategory!)
                    }
                }
            } label: {
              Text("")
            }
            .hidden()
    }
    
    private var errorAlert: Alert {
        Alert(
            title: Text("Error"),
            message: Text(
                viewModel.error?.localizedDescription ?? ""
            )
        )
    }
    
    private var comingSoonAlert: Alert {
        Alert(
            title: Text("Coming soon"),
            message: Text("We are still gathering facts for the animal and they are coming soon. Stay tuned!"),
            dismissButton: Alert.Button.cancel(Text("OK"))
        )
    }
    
    private var showAddAlert: Alert {
        Alert(
            title: Text("Watch Ad"),
            message: nil,
            primaryButton: Alert.Button.cancel(),
            secondaryButton: Alert.Button.default(
                Text("Show Ad"),
                action: {
                    viewModel.didRequestToShowAd()
                }
            )
        )
    }
    
    private func categoriesList(geometry: GeometryProxy) -> some View {
            List($viewModel.categoryItems) { item in
                Button {
                    viewModel.selectItem(with: item.id)
                } label: {
                    AnimalCategoriesListRow(item: item)
                }
                .frame(height: geometry.size.height * 0.14)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
    }
}

struct AnimaCategoriesListView_Previews: PreviewProvider {
    @State static var viewModel = AnimalCategoriesListViewModel(
        imageLoader: FakeImageLoader(),
        getAnimalCategoriesUseCase: GetAnimalCategories(
            categoriesService: FakeAnimalCategoriesService()
        )
    )
    @State static var detailsViewModel: FactsViewModel = {
        FactsViewModel(
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
    }()
    
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
        
        return NavigationView {
            AnimaCategoriesListView(
                viewModel: viewModel,
                detailsViewBuilder: { _ in
                    FactsView(viewModel: detailsViewModel)
                }
            )
        }
    }
}
