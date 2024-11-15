//
//  MonumentViewModel.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 15/11/24.
//

import SwiftUI

@MainActor
class MonumentViewModel: ObservableObject {
    @Published var citiesWithMonuments: [CityWithMonuments] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchCitiesAndMonuments() async {
        isLoading = true
        do {
            // Obtener todas las ciudades
            let cities = try await MonumentManager.shared.getAllCities()
            var result: [CityWithMonuments] = []
            
            // Cargar monumentos para cada ciudad
            for city in cities {
                let monuments = try await MonumentManager.shared.getMonuments(for: city.id)
                result.append(CityWithMonuments(city: city, monuments: monuments))
            }
            
            self.citiesWithMonuments = result
            self.errorMessage = nil
        } catch {
            self.errorMessage = "Failed to load data: \(error.localizedDescription)"
            self.citiesWithMonuments = []
        }
        isLoading = false
    }
}

struct CityWithMonuments: Identifiable {
    let id = UUID() // ID único para cada agrupación
    let city: City
    let monuments: [Monument]
}


