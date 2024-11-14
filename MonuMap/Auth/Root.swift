//
//  Root.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 14/11/24.
//

import SwiftUI

struct Root: View {
    
    @State private var showSignIn: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                MapView(showSignInView: $showSignIn)
            }
        }
        .onAppear(){
            let authUser = try? AuthenticationManager.shared.getAuthenticadedUser()
            self.showSignIn = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignIn){
            NavigationStack{
                LogInView(showSignIn: $showSignIn)
            }
        }
    }
}

#Preview {
    Root()
}
