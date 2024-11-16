//
//  WishlistContentView.swift
//  MonuMap
//
//  Created by Gustavo Vasquez on 16/11/24.
//

import SwiftUI

struct WishlistContentView: View {
    let places: [String: [String]]
    let selectedFilter: FilterOption
    let searchText: String
    
    // Flattened list of all places
    var allPlaces: [String] {
        places.values.flatMap { $0 }
    }
    
    // Filtered places based on the search text
    var filteredPlaces: [String] {
        allPlaces.filter {
            searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        ScrollView {
            if !searchText.isEmpty {
                // Looking by Search Bar: Display flat list of filtered places
                LazyVStack {
                    if filteredPlaces.isEmpty {
                        Text("No results")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(filteredPlaces, id: \.self) { place in
                            HStack(alignment: .top, spacing: 10) {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 160, height: 120)
                                VStack(alignment: .leading, spacing: 10) {
                                    Spacer()
                                    Text(place)
                                        .font(.headline)
                                        .bold()
                                    Text("Description of the place")
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
            } else if selectedFilter == .byName {
                // Looking by Name Filter: Display flat list sorted by name
                LazyVStack {
                    ForEach(allPlaces.sorted(), id: \.self) { place in
                        HStack(alignment: .top, spacing: 10) {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 160, height: 120)
                            VStack(alignment: .leading, spacing: 10) {
                                Spacer()
                                Text(place)
                                    .font(.headline)
                                    .bold()
                                Text("Description of the place")
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
            } else {
                // Looking by City Filter: Display grouped view by city
                LazyVStack {
                    ForEach(places.keys.sorted(), id: \.self) { city in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(city)
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            ForEach(places[city]!, id: \.self) { place in
                                HStack(alignment: .top, spacing: 10) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 160, height: 120)
                                    VStack(alignment: .leading, spacing: 10) {
                                        Spacer()
                                        Text(place)
                                            .font(.headline)
                                            .bold()
                                        Text("Description of the place")
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                        .padding(.bottom, 30) // Extra space between cities
                    }
                }
            }
        }
    }
}
