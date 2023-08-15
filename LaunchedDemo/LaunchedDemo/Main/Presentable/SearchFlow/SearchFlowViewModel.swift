//
//  SearchFlowViewModel.swift
//  LaunchedDemo
//
//  Created by Pasha Berger on 14.08.2023.
//

import Foundation
import Combine

class SearchFlowViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var searchText: String = ""
    @Published var vendors: [VendorCellViewModel] = []
    
    var networkService: NetworkingServiceProtocol
    private var disposable = Set<AnyCancellable>()
    
    init(networkService: NetworkingServiceProtocol) {
        self.networkService = networkService
        Task.init {
            await getVendors()
        }
        setupSearchFlow()
    }
    
    private func setupSearchFlow() {
        let searchTextScheduler: DispatchQueue = .init(label: "vendorSearch", qos: .userInteractive)
        $searchText
            .dropFirst()
            .filter { searchText in
                searchText.count >= 3
            }
            .debounce(
                for: .seconds(0.5),
                scheduler: searchTextScheduler)
            .sink(receiveValue: fetchVendor(with:))
            .store(in: &disposable)
    }
    
    func getVendors() async {
        Task.init {
            let result = await networkService.getVendors()
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.vendors = response.vendors.map { VendorCellViewModel(vendor: $0) }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchVendor(with query: String) {
        if !query.isEmpty {
            Task.init {
                await networkService.searchForVendors(with: query)
                    .receive(on: DispatchQueue.main) // Ensure updates happen on the main thread
                    .sink(receiveCompletion: { [weak self] completion in
                        switch completion {
                        case .failure(let error):
                            print(error)
                        case .finished:
                            break
                        }
                    }) { [weak self] vendorResponse in
                        DispatchQueue.main.async { [weak self] in
                            self?.vendors = vendorResponse.vendors.map { VendorCellViewModel(vendor: $0) }
                        }
                    }.store(in: &disposable)
            }
        } else {
            Task.init {
                await getVendors()
            }
        }
    }
}
