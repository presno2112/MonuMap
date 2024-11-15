//
//  UserProfileView.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 14/11/24.
//

import SwiftUI

struct UserProfileView: View {
    @State var showCard: Bool = false
    var rectangles = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
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
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(rectangles, id: \.self) { index in
                            Button{
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                    showCard.toggle()
                                }
                            }label: {
                                    BadgeView()
                                }
                        }
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showCard) {
            FlipCard(showCard: $showCard)
                .transition(.scale(scale: 0.1, anchor: .center)) // Scale transition for pop effect
                .animation(.spring(response: 0.5, dampingFraction: 0.7))
        }
    }
}

struct BadgeView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.gray)
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
                .fill(Color.gray.opacity(0.1))
                .frame(width: 320, height: 170)
                .padding(.top, 70)
            
            VStack(spacing: 10) {
                Circle()
                    .fill(.gray)
                    .frame(width: 140, height: 140)
                
                Text("Name Last Name")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Description Description Description Description\nDescription Description")
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


