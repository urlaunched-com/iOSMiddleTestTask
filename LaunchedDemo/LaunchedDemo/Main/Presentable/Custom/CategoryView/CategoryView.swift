//
//  CategoryView.swift
//  LaunchedDemo
//
//  Created by Pasha Berger on 15.08.2023.
//

import SwiftUI

struct CategoryView: View {
    
    //MARK: - Properties

    var category: Category
    
    var body: some View {
        HStack {
            ImageLoaderView(url: URL(string: category.image.mediaURL) ?? URL(string: Constants.Utility.plaholderSVGIcon)!)
                .foregroundColor(ColorPalette.black)
            Text(category.name)
                .font(AppFonts.subheader)
                .foregroundColor(ColorPalette.grayPrimary)
                .multilineTextAlignment(.center)
                
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryView(category: Category(id: 1, name: "Butchery", image: CoverPhoto(id: 2, mediaURL: "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg", mediaType: .image)))
    }
}

