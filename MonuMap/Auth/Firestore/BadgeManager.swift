//
//  BadgeManager.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 18/11/24.
//

import Foundation
import FirebaseFirestore

final class BadgeManager {
    static let shared = BadgeManager()
    private init() { }

    private let badgesCollection = Firestore.firestore().collection("badges")
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func getBadge(named name: String) async throws -> Badge? {
        let querySnapshot = try await badgesCollection.whereField("name", isEqualTo: name).getDocuments()
        guard let document = querySnapshot.documents.first else {
            return nil
        }
        return try document.data(as: Badge.self, decoder: decoder)
    }
}
