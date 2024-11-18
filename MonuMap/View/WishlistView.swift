//
//  WishlistView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 11/11/24.
//

import SwiftUI

enum FilterOption {
    case byCity
    case byName
}

struct WishlistView: View {
    @State private var searchText = ""
    @State private var selectedFilter: FilterOption = .byCity // Default filter
    
    let places = [
        "Napoli": ["Lugar 1", "Lugar 2", "Lugar 3"],
        "Roma": ["Lugar A", "Lugar B"]
    ]
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    SearchBar(searchText: $searchText)
                        .padding(.leading)
                    Menu{
                        Button("By city", action: { selectedFilter = .byCity })
                        Button("By name", action: { selectedFilter = .byName })
                        
                    }label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.system(size: 20))
                    }.padding(.trailing, 20)
                }
                ScrollView{
                    LazyVStack{
                        ForEach(places.keys.sorted(), id: \.self){ city in
                            VStack(alignment: .leading, spacing: 10){
                                Text(city)
                                    .font(.title2)
                                    .foregroundStyle(Color("MainBlue"))
                                    .bold()
                                    .padding(.horizontal)
                                ForEach(places[city]!, id: \.self) { place in
                                    HStack(alignment: .top, spacing: 10){
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 160, height: 120)
                                        VStack(alignment: .leading, spacing: 10){
                                            Spacer()
                                            Text(place)
                                                .font(.headline)
                                                .bold()
                                            Text("description of the place")
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
                    .padding(.trailing, 20)
                }
                WishlistContentView(
                    places: places,
                    selectedFilter: selectedFilter,
                    searchText: searchText
                )
            }
            .navigationTitle("Wishlist")
        }
    }
}

#Preview {
    WishlistView()
}
