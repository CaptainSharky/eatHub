//
//  SearchViewModel.swift
//  EatHub
//
//  Created by anastasiia talmazan on 2025-03-28.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var results: [Meal] = []
    @FocusState var isTextFieldFocused: Bool
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init() {
        
    }
    
    func search() {
        
    }
}
