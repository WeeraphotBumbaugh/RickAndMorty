//
//  SquareAsyncImage.swift
//  RickAndMorty
//
//  Created by Weeraphot Bumbaugh on 9/20/25.
//
import SwiftUI
struct SquareAsyncImage: View {
    let url: URL?
    let size: CGFloat
    var cornerRadius: CGFloat = 10
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let img):
                img.resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipped()
                    .cornerRadius(cornerRadius)
                
            case .failure(_):
                placeholder
                
            case .empty:
                placeholder
                
            @unknown default:
                placeholder
            }
        }
    }
    
    private var placeholder: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.gray.opacity(0.2))
            .frame(width: size, height: size)
            .overlay {
            ProgressView().scaleEffect(0.8)
        }
    }
}
