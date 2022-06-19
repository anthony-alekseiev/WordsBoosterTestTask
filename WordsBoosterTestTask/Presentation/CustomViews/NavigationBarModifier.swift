//
//  NavigationBarModifier.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 19.06.2022.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
        
    var backgroundColor: Color
    
    init(
        backgroundColor: Color = .clear,
        barTintColor: Color = .white,
        shadowApplied: Bool = false
    ) {
        self.backgroundColor = backgroundColor
        let tintColor = UIColor(barTintColor)
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: tintColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
        
        if shadowApplied {
            appearance.shadowColor = nil
            appearance.shadowImage = UIImage(named: "shadow_image")!
        }
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor(barTintColor)
        
        
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    self.backgroundColor
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
