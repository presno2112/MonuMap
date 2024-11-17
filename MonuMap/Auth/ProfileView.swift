//
//  ProfileView.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 13/11/24.
//

import SwiftUI

@MainActor
//final class ProfileViewModel: ObservableObject {
//    
//    @Published private(set) var user: DBUser? = nil
//    
//    func loadCurrentUser() async throws {
//        let authDataResult = try AuthenticationManager.shared.getAuthenticadedUser()
//        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
//    }
//}

final class ProfileViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil

    func loadCurrentUser() async throws {
        self.user = try await UserManager.shared.getCurrentUser()
    }
}

struct ProfileView: View {
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some View {
        VStack {
            if let monuments = userViewModel.user?.monuments, !monuments.isEmpty {
                List(monuments, id: \.self) { monument in
                    Text(monument)
                }
            } else {
                Text("No monuments found.")
            }
        }
        .task {
            try? await userViewModel.loadCurrentUser()
        }
    }
}

#Preview {
    ProfileView()
}
