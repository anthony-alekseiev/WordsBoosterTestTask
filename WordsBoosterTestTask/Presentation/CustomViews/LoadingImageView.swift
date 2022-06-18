//
//  LoadingImageView.swift
//  WordsBoosterTestTask
//
//  Created by Anton Aleksieiev on 18.06.2022.
//

import SwiftUI

struct LoadingImageView: View {
    
    @Binding var image: UIImage?
    @Binding var isLoading: Bool
    
    var body: some View {
        ZStack {
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } else {
                Image("default_placeholder")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                if isLoading {
                    ProgressView()
                        .tint(.white)
                }
            }
        }
        
    }
}

struct LoadingImage_Previews: PreviewProvider {
    @State static var img: UIImage?
    @State static var isLoading: Bool = true
    
    static var previews: some View {
        LoadingImageView(image: $img, isLoading: $isLoading)
    }
}
