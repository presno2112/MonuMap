//
//  MonumentViewModel.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 15/11/24.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class MonumentViewModel: ObservableObject {
    @Published var citiesWithMonuments: [(city: City, monuments: [Monument])] = [] // Almacenar ciudades y sus monumentos
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchCitiesAndMonuments() async {
        isLoading = true
        do {
            let citiesSnapshot = try await Firestore.firestore().collection("cities").getDocuments()
            
            var citiesWithMonuments: [(city: City, monuments: [Monument])] = []
            
            for cityDocument in citiesSnapshot.documents {
                // Obtener el ID del documento generado automáticamente
                //let cityId = cityDocument.documentID
                
                do {
                    // Usamos un bloque do-catch para manejar la decodificación
                    let city = try cityDocument.data(as: City.self)
                    // Ahora pasamos el cityId que es el documentID generado automáticamente
                    let monumentsSnapshot = try await cityDocument.reference.collection("monuments").getDocuments()
                    let monuments = try monumentsSnapshot.documents.compactMap { document in
                        try document.data(as: Monument.self)
                    }
                    
                    print("Cities with Monuments:")
                    for cityWithMonuments in citiesWithMonuments {
                        print("City: \(cityWithMonuments.city.name), ID: \(cityWithMonuments.city.id), Monuments: \(cityWithMonuments.monuments.count)")
                    }
                    
                    // Verificar si se cargaron los monumentos
                    print("City: \(city.name), Monuments count: \(monuments.count)")
                    citiesWithMonuments.append((city: city, monuments: monuments))
                } catch {
                    // Capturamos el error en caso de que la decodificación falle
                    print("Error decoding city \(cityDocument.documentID): \(error)")
                }
            }
            
            self.citiesWithMonuments = citiesWithMonuments
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load cities and monuments: \(error.localizedDescription)"
            citiesWithMonuments = []
        }
        isLoading = false
    }
}

struct CityWithMonuments: Identifiable {
    let id = UUID() // ID único para cada agrupación
    let city: City
    let monuments: [Monument]
}


