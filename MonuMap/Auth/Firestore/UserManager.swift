//
//  UserManager.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 14/11/24.
//

import Foundation
import FirebaseFirestore

struct DBUser: Codable {
    let userId: String
    let email: String?
    let photoUrl: String?
    let name: String?
    let badges: [String]
    let monuments: [String]
    
    init(auth: AuthDataResultModel, name: String? = nil, badges: [String] = [], monuments: [String] = []) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoURL
        self.name = name
        self.badges = badges
        self.monuments = monuments
    }
}

final class UserManager{
    
    static let shared = UserManager()
    private init(){
        
    }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference{
        userCollection.document(userId)
    }
    
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
    
    func createNewUser(user: DBUser) async throws{
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
    }
    
    func getCurrentUser() async throws -> DBUser {
        let authDataResult = try AuthenticationManager.shared.getAuthenticadedUser()
        return try await getUser(userId: authDataResult.uid)
    }
}
