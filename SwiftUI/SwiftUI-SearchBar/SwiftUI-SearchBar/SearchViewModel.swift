//
//  SearchViewModel.swift
//  SwiftUI-SearchBar
//
//  Created by Cristian Banarescu on 17.06.2024.
//

import Foundation

struct SearchViewModel {
    private let userDefaults = UserDefaults.standard
    
    func store(searchTerms: [String]) {
        userDefaults.setValue(searchTerms, forKey: "searchTerms")
    }
    
    func retrieveSearchTerms() -> [String] {
        userDefaults.stringArray(forKey: "searchTerms") ?? []
    }
}
