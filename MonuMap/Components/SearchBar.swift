//
//  SearchBar.swift
//  MonuMap
//
//  Created by Sebastian Presno on 11/11/24.
//

import SwiftUI

struct SearchBar: View {
    @State var searchText: String = ""
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.secondary)
            TextField("Search", text: $searchText)
            if searchText != "" {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.medium)
                    .foregroundColor(Color(.systemGray3))
                    .padding(3)
                    .onTapGesture {
                        withAnimation {
                            self.searchText = ""
                          }
                    }
            }
        }
        .padding(7)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.vertical, 19)
    }
}

#Preview {
    SearchBar()
}
