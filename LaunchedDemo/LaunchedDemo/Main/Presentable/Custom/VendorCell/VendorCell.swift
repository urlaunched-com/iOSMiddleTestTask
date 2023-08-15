//
//  VendorCell.swift
//  LaunchedDemo
//
//  Created by Pasha Berger on 15.08.2023.
//

import Foundation
import SwiftUI

struct VendorCell: View {
    
    private let viewModel: VendorCellViewModel
    
    init(viewModel: VendorCellViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK: - Properties
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: viewModel.image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(12)
                        .overlay(
                            HStack {
                                Spacer()
                                VStack {
                                    viewModel.isSaved
                                    ? Image(Constants.Vendor.saved)
                                        .padding([.top, .leading])
                                    : Image(Constants.Vendor.unsaved)
                                        .padding([.top, .leading])
                                    Spacer()
                                }
                            }
                        )
                        .overlay(
                            VStack {
                                Spacer()
                                HStack(alignment: .bottom) {
                                    Text(viewModel.location)
                                        .foregroundColor(ColorPalette.grayPrimary)
                                        .font(AppFonts.subheader)
                                        .padding(8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .foregroundColor(ColorPalette.white.opacity(0.9))
                                        )
                                    Spacer()
                                }
                                .padding([.bottom, .leading], 16)
                            }
                        )
                default:
                    ColorPalette.grayPrimary
                        .frame(height: 250)
                        .cornerRadius(12)
                }
            }
            
            Text(viewModel.name)
                .font(AppFonts.header)
                .foregroundColor(ColorPalette.grayPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                viewModel.categories.count <= 2
                ? makeSingleRow(categories: viewModel.categories).eraseToAnyView()
                : makeMultipleRows(categories: viewModel.categories).eraseToAnyView()
                
            }
            Text(viewModel.tags.map { $0.name }.joined(separator: " · "))
                           .font(.subheadline)
                           .foregroundColor(.gray)
        }
        .padding()
    }
    
    
    func makeSingleRow(categories: [Category]) -> some View {
        HStack(spacing: 16) {
            ForEach(categories, id: \.id) { category in
                CategoryView(category: category)
            }
        }
    }
    
    func makeMultipleRows(categories: [Category]) -> some View {
        ForEach(0..<categories.count / 2 + categories.count % 2, id: \.self) { row in
            HStack(spacing: 16) {
                ForEach(0..<2) { column in
                    let index = row * 2 + column
                    if index < categories.count {
                        CategoryView(category: categories[index])
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Spacer()
                    }
                }
            }
        }
    }
}
