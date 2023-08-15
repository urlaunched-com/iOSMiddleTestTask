//
//  VendorCellViewModel.swift
//  LaunchedDemo
//
//  Created by Pasha Berger on 15.08.2023.
//

import Foundation

class VendorCellViewModel: Identifiable {
    
    private let vendor: Vendor
    
    var id: Int {
        vendor.id
    }
    
    var location: String {
        vendor.areaServed
    }
    
    var name: String {
        vendor.companyName
    }
    
    var image: String {
        vendor.coverPhoto.mediaURL
    }
    
    var categories: [Category] {
        vendor.categories
    }
    
    var tags: [Tag] {
        vendor.tags
    }
    
    var isSaved: Bool {
        vendor.favorited
    }
    
    init(vendor: Vendor) {
        self.vendor = vendor
    }
}
