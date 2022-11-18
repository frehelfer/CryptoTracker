//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 17/11/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    @FocusState private var searchIsFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty
                    ? .theme.secondaryText
                    : .theme.accent
                )
            
            TextField("Search by na,e or symbol...", text: $searchText)
                .foregroundColor(.theme.accent)
                .keyboardType(.default)
                .focused($searchIsFocused)
                .autocorrectionDisabled()
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchIsFocused = false
                            searchText = ""
                        }
                    
                }
        }
        .font(.headline)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: .theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    searchIsFocused = false
                }
            }
        }
    }
    
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
