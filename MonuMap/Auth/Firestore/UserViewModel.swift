//
//  UserViewModel.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 16/11/24.
//

import Foundation
import FirebaseFirestore

@MainActor
final class UserViewModel: ObservableObject {
    @Published private(set) var user: DBUser?
    
    func loadCurrentUser() async throws {
        let authData = try AuthenticationManager.shared.getAuthenticadedUser()
        self.user = try await UserManager.shared.getUser(userId: authData.uid)
    }
    
    func getBadges() -> [String] {
        guard let user = user else {
            print("User not loaded")
            return []
        }
        print("User badges: \(user.badges)")
        return user.badges
    }
    
    func getMonuments() -> [String] {
        guard let user = user else {
            print("User not loaded")
            return []
        }
        return user.monuments
    }
    
    func addBadge(_ badgeName: String) async throws {
        guard let user = user else {
            throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not loaded"])
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.userId) // Asegúrate de tener `id` en tu modelo `User`
        
        do {
            try await userRef.setData([
                "badges": FieldValue.arrayUnion([badgeName])
            ], merge: true) 
            print("Badge added successfully to user \(user.userId)")
        } catch {
            throw error
        }
    }
}
