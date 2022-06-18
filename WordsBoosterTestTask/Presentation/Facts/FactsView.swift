//
//  FactsView.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 19.06.2022.
//

import SwiftUI

struct FactsView: View {
    @Binding var id: String
    
    var body: some View {
        Text(id)
              .navigationBarColor(
                  Color(red: 147/256, green: 91/256, blue: 191/256)
              )
    }
}

struct FactsView_Previews: PreviewProvider {
    @State static var id: String = "1"
    static var previews: some View {
        NavigationView {
            FactsView(id: $id)
        }
        
    }
}
