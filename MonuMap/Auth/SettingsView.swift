//
//  SettingsView.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 14/11/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: Observable{
    
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
    
    @State private var settingsViewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List{
            Button("Log Out"){
                Task{
                    do {
                        try settingsViewModel.signOut()
                        showSignInView = true
                        
                    } catch{
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView(showSignInView: .constant(false))
}
