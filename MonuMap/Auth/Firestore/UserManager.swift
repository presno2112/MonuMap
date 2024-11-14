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
    let username: String?
    let name: String?
    let lastName: String?
    let badges: [Badge]?
    let monuments: [Monument]?
    
    init(auth: AuthDataResultModel){
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoURL
        self.username = ""
        self.name = ""
        self.lastName = ""
        self.badges = nil
        self.monuments = nil
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
    
//    func createNewUser(auth: AuthDataResultModel) async throws{
//        var userData: [String: Any] = [
//            "user_id" : auth.uid,
//            "email" : auth.email ?? ""
//        ]
//        if let photoUrl = auth.photoURL{
//            userData["photo_url"] = photoUrl
//        }
//        
//        try await userDocument(userId: auth.uid).setData(userData, merge: false)
//    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
    }
    
//    func getUser(userId: String) async throws -> DBUser {
//        let snapshot = try await userDocument(userId: userId).getDocument()
//        
//        guard let data = snapshot.data() else{
//            throw URLError(.badServerResponse)
//        }
//        
//        let email = data["email"] as? String
//        let photoUrl = data["photo_url"] as? String
//        
//        return DBUser(userId: userId, email: email, photoUrl: photoUrl)
//    }
}
