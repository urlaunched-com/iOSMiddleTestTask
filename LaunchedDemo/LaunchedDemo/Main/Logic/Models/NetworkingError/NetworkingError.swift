//
//  NetworkingError.swift
//  LaunchedDemo
//
//  Created by Pasha Berger on 14.08.2023.
//

import Foundation

enum NetworkingError: Error {
    
    case parsing(message: String)
    case network(message: String)
    
    var localizedDescription: String {
        switch self {
        case .parsing(let message):
            return message
            
        case .network(let message):
            return message
        }
    }
}
