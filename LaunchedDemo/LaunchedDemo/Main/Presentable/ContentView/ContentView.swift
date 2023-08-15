//
//  ContentView.swift
//  LaunchedDemo
//
//  Created by Pasha Berger on 14.08.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            SearchFlowView(
                viewModel: SearchFlowViewModel(
                    networkService: NetworkService()
                )
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
