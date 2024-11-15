//
//  MonumentManager.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 15/11/24.
//

import Foundation
import FirebaseFirestore

struct Monument: Identifiable, Codable {
    var id: String?
    var name: String
    var creator: String?
    var description: String
    var picture: String
    var location: String
    var coordinates: GeoPoint
}

final class MonumentManager {
    static let shared = MonumentManager()
    private init() { }
    
    private let citiesCollection = Firestore.firestore().collection("cities")
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    /// Obtiene todas las ciudades
    func getAllCities() async throws -> [City] {
        let querySnapshot = try await citiesCollection.getDocuments()
        return try querySnapshot.documents.compactMap { document in
            try document.data(as: City.self, decoder: decoder)
        }
    }
    
    /// Obtiene todos los monumentos de una ciudad específica (subcolección `monuments`)
    func getMonuments(for cityId: String) async throws -> [Monument] {
        let monumentsCollection = citiesCollection.document(cityId).collection("monuments")
        let querySnapshot = try await monumentsCollection.getDocuments()
        return try querySnapshot.documents.compactMap { document in
            try document.data(as: Monument.self, decoder: decoder)
        }
    }
}
