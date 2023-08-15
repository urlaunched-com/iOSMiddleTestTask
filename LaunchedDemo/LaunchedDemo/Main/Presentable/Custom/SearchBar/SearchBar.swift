//
//  SearchBar.swift
//  LaunchedDemo
//
//  Created by Pasha Berger on 14.08.2023.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    
    //MARK: - Properties
    
    @Binding var searchText: String
    @State var showClearButton: Bool = false
    
    var placeholder = Constants.Search.title
    
    var body: some View {
        
        TextField(placeholder, text: $searchText, onEditingChanged: { editing in
            self.showClearButton = editing
        }, onCommit: {
            self.showClearButton = false
        })
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(ColorPalette.white)
        .cornerRadius(12)
        .background(RoundedRectangle(cornerRadius: 12)
            .foregroundColor(Color.white)
            .shadow(color: .gray.opacity(0.5),
                    radius: 1,
                    x: -1,
                    y: 2)
        )
        .overlay() {
            Image(Constants.Search.Icons.searchIcon)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .trailing)
                .padding()
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    
    @State static var searchText: String = ""
    
    static var previews: some View {
        SearchBar(searchText: $searchText)
    }
}
