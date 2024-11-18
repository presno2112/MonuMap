//
//  MapButtonsView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 15/11/24.
//

import SwiftUI

struct MapButtonsView : View{
    @Binding var navigateToProfile: Bool
    @Binding var navigateToWishlist: Bool
    @Binding var isSheetPresented: Bool
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        navigateToProfile.toggle()
                        isSheetPresented.toggle()
                    }) {
                        ZStack{
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color(UIColor.systemBackground))
                                .shadow(radius: 10)
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("MainBlue"))
                        }
                    }
                    .padding(.top, 50)
                    .padding(.trailing, 16)
                    
                    Button(action: {
                        navigateToWishlist.toggle()
                        isSheetPresented.toggle()
                    }) {
                        ZStack{
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color(UIColor.systemBackground))
                                .shadow(radius: 10)
                            Image(systemName: "text.badge.plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("MainBlue"))
                        }
                    }
                    .padding(.trailing, 16)
                    .padding(.top, 8)
                }
            }
            Spacer()
        }
        .padding(.top, 40)
    }
}

#Preview {
    MapButtonsView(navigateToProfile: .constant(false), navigateToWishlist: .constant(false), isSheetPresented: .constant(false))
}
