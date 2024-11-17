//
//  UserViewModel.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 16/11/24.
//

import Foundation

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
        return user.badges
    }
    
    func getMonuments() -> [String] {
        guard let user = user else {
            print("User not loaded")
            return []
        }
        return user.monuments
    }
}
