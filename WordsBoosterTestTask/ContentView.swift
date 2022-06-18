//
//  ContentView.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 16.06.2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    let apiTester: TestApi
    
    init(apiTester: TestApi) {
        self.apiTester = apiTester
    }
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Button("Press to load") {
                apiTester.doTest()
            }
        }
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient: AnimalCategoriesService = AnimalCategoriesAPIClient()
        let apiTester: TestApi = TestApi(api: apiClient)
        ContentView(apiTester: apiTester)
    }
}
