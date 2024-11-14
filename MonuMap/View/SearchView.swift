//
//  SearchView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 07/11/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var isSheetPresented: Bool
    @State var searchText: String = ""
    @State private var currentHeight: CGFloat = 0
//    @Environment(AppController.self) private var appController
    
    // Example list of monuments
    var monuments: [(image: UIImage, title: String, description: String)] = [
        (UIImage(named: "coliseo")!, "Eiffel Tower", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum"),
        (UIImage(named: "coliseo")!, "Louvre Museum", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum"),
        (UIImage(named: "coliseo")!, "Notre Dame Cathedral", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum")
    ]
    
    var filteredMonuments: [(image: UIImage, title: String, description: String)] {
        // Filter monuments based on searchText
        if searchText.isEmpty {
            return monuments
        } else {
            return monuments.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack {
                    SearchBar(searchText: $searchText)
                        .padding(.leading)
                    Button {
                        
                    } label: {
                        Image(systemName: "camera.circle.fill")
                            .font(.largeTitle)
                    }
                    .padding()
                }
                .padding(.horizontal)
                .padding(.top, currentHeight <= 50 ? 0 : 10)
                
                if filteredMonuments.count == 0 && searchText != "" {
                    Text("No results")
                }
                else {
                    CityMonumentsView(cityName: "Roma", monuments: filteredMonuments)
                    CityMonumentsView(cityName: "Napoli", monuments: filteredMonuments)
                }
                
                Button{
//                    do{
//                        try appController.signOut()
//                    } catch{
//                        print(error.localizedDescription)
//                    }
                }label: {
                    Text("Log Out")
                }
                Spacer()
            }
            .onAppear {
                currentHeight = geometry.size.height
            }
            .onChange(of: geometry.size.height) { newHeight in
                currentHeight = newHeight
            }
        }
    }
}


#Preview {
    SearchView(isSheetPresented: .constant(true))
}
