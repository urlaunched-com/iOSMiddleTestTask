//
//  ImageLoaderView.swift
//  LaunchedDemo
//
//  Created by Pasha Berger on 15.08.2023.
//

import SwiftUI
import SVGKit

struct ImageLoaderView: View {
    let url: URL
    
    @State private var svgImage: UIImage?
    
    enum ImageType {
        case svg
        case jpg
    }
    
    var imageType: ImageType {
        if url.absoluteString.lowercased().hasSuffix(".svg") {
            return .svg
        } else if url.absoluteString.lowercased().hasSuffix(".jpg") || url.absoluteString.lowercased().hasSuffix(".jpeg") {
            return .jpg
        } else {
            return .jpg
        }
    }
    
    var body: some View {
        if imageType == .svg {
            if let svgImage = svgImage {
                Image(uiImage: svgImage)
                    .resizable()
                    .frame(width: 25, height: 25)
            } else {
                Color.gray
                    .frame(width: 25, height: 25)
                    .onAppear {
                        loadSVGImage(url: url)
                    }
            }
        } else {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                default:
                    Color.gray
                        .frame(width: 100, height: 100)
                }
            }
        }
    }
    
    func loadSVGImage(url: URL) {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let svgImage = SVGKImage(data: data) {
                    self.svgImage = svgImage.uiImage
                }
            } catch {
                print("Error loading SVG image: \(error)")
            }
        }
    }
}
