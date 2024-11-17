//
//  Root.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 14/11/24.
//

import SwiftUI

struct Root: View {
    
    @State private var showSignIn: Bool = false
    //@StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
//        Group {
//            // Si el usuario está autenticado, mostramos la HomeView
//            if authViewModel.isAuthenticated {
//                MapView()  // Aquí iría tu vista principal de la app
//            } else {
//                SignInView()  // Si no está autenticado, mostramos la vista de inicio de sesión
//            }
//        }
//        .onAppear {
//            // Al aparecer la vista, se verifica automáticamente el estado de autenticación
//            authViewModel.checkAuthentication()
//        }
        MapView()
            .edgesIgnoringSafeArea(.top)
            .onAppear(){
                let authUser = try? AuthenticationManager.shared.getAuthenticadedUser()
                self.showSignIn = authUser == nil
            }
//            .fullScreenCover(isPresented: $showSignIn){
//                    LogInView(showSignIn: $showSignIn)
//        }
    }
}

#Preview {
    Root()
}
