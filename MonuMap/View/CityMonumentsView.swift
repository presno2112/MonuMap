//
//  CityMonumentsView.swift
//  MonuMap
//
//  Created by Gustavo Vasquez on 13/11/24.
//

import SwiftUI

struct MonumentView: View {
    let monument: Monument
    
    @State private var isHeartFilled = false // State to track heart status
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                // Imagen del monumento
                AsyncImage(url: URL(string: monument.picture)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 200, height: 120)
                .clipped()
                .cornerRadius(8)

                // Botón de favorito
                Button(action: {
                    isHeartFilled.toggle()
                }) {
                    Image(systemName: isHeartFilled ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                        .padding(8)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(monument.name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(monument.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 8)
        }
        .frame(width: 200)
    }
}

struct CityMonumentsView: View {
    @StateObject private var viewModel = MonumentViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(viewModel.citiesWithMonuments) { cityWithMonuments in
                            VStack(alignment: .leading, spacing: 8) {
                                // Nombre de la ciudad
                                Text(cityWithMonuments.city.name)
                                    .foregroundStyle(Color("MainBlue"))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                // Carrusel de monumentos
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(cityWithMonuments.monuments) { monument in
                                            MonumentView(monument: monument)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchCitiesAndMonuments()
                }
            }
        }
    }
}

#Preview {
    CityMonumentsView()
}
