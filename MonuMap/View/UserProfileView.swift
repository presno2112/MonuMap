//
//  UserProfileView.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 14/11/24.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var badgeViewModel = BadgeViewModel()
    @State var selectedBadge: Badge?
    @State var showCard: Bool = false
    var rectangles = [1, 2, 3, 4]
    var images  = ["Badge Colosseum", "Badge Maradona Mural", "Badge Pizzeria Da Michele", "Badge Basilica Di San Pietro"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    UserInfo()
                    
                    Text("My Badges")
                        .bold()
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 30, leading: 30, bottom: -10, trailing: 0))
                        .foregroundStyle(Color("MainBlue"))
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(badgeViewModel.badges) { badge in
                            Button{
                                selectedBadge = badge
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                    showCard.toggle()
                                    
                                }
                            }label: {
                                BadgeView(image: badge.image)
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                Task {
                    try await userViewModel.loadCurrentUser()  // Cargar el usuario actual
                    let badgeNames = userViewModel.getBadges()  // Obtener los nombres de los badges
                    await badgeViewModel.loadBadges(for: badgeNames)  // Cargar los badges con esos nombres
                    print("Loaded badges: \(badgeViewModel.badges)")
                }
            }
        }
        .sheet(isPresented: $showCard) {
            FlipCard(showCard: $showCard, selectedBadge: $selectedBadge)
                .transition(.scale(scale: 0.1, anchor: .center)) // Scale transition for pop effect
                .animation(.spring(response: 0.5, dampingFraction: 0.7))
        }
    }
}

struct BadgeView: View {
    var image : String = ""
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 2)
    }
}

struct UserInfo: View {
    var body: some View {
        ZStack {
            // Background rectangle with rounded corners
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("MainBlue").opacity(0.4))
                .frame(width: 320, height: 170)
                .padding(.top, 70)
            
            VStack(spacing: 10) {
                Circle()
                    .fill(Color("MainBlue"))
                    .frame(width: 140, height: 140)
                
                Text("Hector Daniel Valdes")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Apple developer academy student")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            }
        }
        .padding(.top, 20)
    }
}

#Preview {
    UserProfileView()
}


