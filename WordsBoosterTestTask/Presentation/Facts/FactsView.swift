//
//  FactsView.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 19.06.2022.
//

import SwiftUI

struct FactsView: View {
    @Binding var category: AnimalCategory
    
    var body: some View {
        ZStack {
            Color(red: 147/256, green: 91/256, blue: 191/256)
                .ignoresSafeArea()
            GeometryReader { geometry in
//                FactCard(item: nil, {
//                    
//                }, {
//                    
//                })
                EmptyView()
                    .frame(height: geometry.size.height * 0.62)
                    .padding(.horizontal, 20)
                    .navigationStyle(
                        Color(red: 147/256, green: 91/256, blue: 191/256),
                        barTintColor: .black,
                        applyShadow: true
                    )
                    .navigationTitle(category.title)
            }
        }
    }
}

struct FactsView_Previews: PreviewProvider {
    @State static var category = AnimalCategory(
        title: "Dogs 🐕",
        description: "Different facts about dogs",
        image: URL(string: "https://google.com")!,
        order: 1,
        status: .free,
        content: []
    )
    static var previews: some View {
        NavigationView {
            FactsView(category: $category)
        }
        
    }
}
