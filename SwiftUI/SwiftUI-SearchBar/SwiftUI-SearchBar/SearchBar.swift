//
//  SearchBar.swift
//  SwiftUI-SearchBar
//
//  Created by Cristian Banarescu on 17.06.2024.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var searchTermSearched: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var searchTermSearched: String
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTermSearched = searchBar.text ?? ""
        }
        
        init(text: Binding<String>, searchTermSearched: Binding<String>) {
            _text = text
            _searchTermSearched = searchTermSearched
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, searchTermSearched: $searchTermSearched)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search for a framework"
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}
