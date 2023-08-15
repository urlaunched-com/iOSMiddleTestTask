//
//  NetworkService.swift
//  LaunchedDemo
//
//  Created by Pasha Berger on 14.08.2023.
//

import Foundation
import Combine

protocol NetworkingServiceProtocol {
    func getVendors() async -> Result<VendorResponse, NetworkingError>
    func searchForVendors(with query: String) async -> AnyPublisher<VendorResponse, NetworkingError>
}

final class NetworkService: NetworkingServiceProtocol {
    
    func getVendors() async -> Result<VendorResponse, NetworkingError> {
        guard let url = Bundle.main.url(forResource: "vendors", withExtension: "json") else {
            return .failure(NetworkingError.parsing(message: "Failed to create URL"))
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let vendorResponse = try JSONDecoder().decode(VendorResponse.self, from: data)
            return .success(vendorResponse)
        } catch {
            return .failure(NetworkingError.network(message: error.localizedDescription))
        }
    }
    
    func searchForVendors(with query: String) async -> AnyPublisher<VendorResponse, NetworkingError> {
        guard let url = Bundle.main.url(forResource: "vendors", withExtension: "json") else {
            return Fail(error: NetworkingError.parsing(message: "Failed to get url"))
                .eraseToAnyPublisher()
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedResponse = try JSONDecoder().decode(VendorResponse.self, from: data)
            let filteredVendors = decodedResponse.vendors.filter { vendor in
                vendor.companyName.lowercased().contains(query.lowercased())
            }
            let filteredResponse = VendorResponse(vendors: filteredVendors)
            return Just(filteredResponse)
                .setFailureType(to: NetworkingError.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkingError.parsing(message: error.localizedDescription))
                .eraseToAnyPublisher()
        }
    }
}
