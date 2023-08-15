//
//  Constants.swift
//  LaunchedDemo
//
//  Created by Pasha Berger on 14.08.2023.
//

import Foundation

enum Constants {
    struct Search {
        static var title = "Search..."
        static var emptyHeader = "Sorry! No results found..."
        static var emptySubheader = "Please try a different search request \nor browse businesses from the list"
        
        struct Icons {
            static var searchIcon = "icon_search"
        }
    }
    
    struct Vendor {
        static var saved = "save_active"
        static var unsaved = "save_inactive"
    }
    
    struct Utility {
        static var plaholderSVGIcon = "https://placehold.co/50x50/svg"
    }
}
