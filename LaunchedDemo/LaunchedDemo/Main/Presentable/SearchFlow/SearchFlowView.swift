//
//  SearchFlowView.swift
//  LaunchedDemo
//
//  Created by Pasha Berger on 14.08.2023.
//

import Foundation
import SwiftUI

struct SearchFlowView: View {
    
    @ObservedObject var viewModel: SearchFlowViewModel
    
    var body: some View {
        VStack {
            SearchBar(
                searchText: $viewModel.searchText,
                placeholder: Constants.Search.title)
            
            if !viewModel.vendors.isEmpty {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.vendors) { viewModel in
                            VendorCell(viewModel: viewModel)
                        }
                    }
                }
            } else {
                Spacer()
                
                VStack(spacing: 10) {
                    Text(Constants.Search.emptyHeader)
                        .foregroundColor(ColorPalette.darkGreen)
                        .font(AppFonts.largeTitle)
                        .frame(alignment: .center)
                    Text(Constants.Search.emptySubheader)
                        .foregroundColor(ColorPalette.grayPrimary)
                        .font(AppFonts.subheader)
                        .frame(alignment: .center)
                }
                
                Spacer()
            }
        }
        .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFlowView(viewModel: SearchFlowViewModel(networkService: NetworkService()))
    }
}
