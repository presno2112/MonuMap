//
//  ProfileView.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 13/11/24.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticadedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}

struct ProfileView: View {
    
    @StateObject private var profileViewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List{
            if let user = profileViewModel.user {
                Text("UserId: \(user.userId) ")
            }
        }
        .task{
            try? await profileViewModel.loadCurrentUser()
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink{
                    SettingsView(showSignInView: $showSignInView)
                }label:{
                    Text("Settings")
                }
            }
        }
    }
}

#Preview {
    ProfileView(showSignInView: .constant(false))
}
