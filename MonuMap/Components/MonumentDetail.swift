//
//  MonumentDetail.swift
//  MonuMap
//
//  Created by Sebastian Presno on 13/11/24.
//

import SwiftUI

struct MonumentDetail: View {
    @Binding var isSheetPresented : Bool
    @Binding var isPresented: Bool
    let placeName: String
    var onGetBadge: () -> Void
    var onAddToWishlist: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            // Header Text
            ZStack {
                HStack {
                    Button {
                        isPresented = false
                        isSheetPresented = true
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.white)
                    }
                    .padding(.leading, 10) // Move the button closer to the left edge
                    
                    Spacer()
                }
                
                Text(placeName)
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
            }

            HStack {
                // Image Placeholder
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 120, height: 100)
                    .padding()
                
                // Buttons
                VStack(spacing: 8) {
                    Button(action: onGetBadge) {
                        Text("Get my badge")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 140, height: 40)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(15)
                    }
                    .padding(.bottom)
                    
                    Button(action: onAddToWishlist) {
                        Text("Add to wishlist")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 140, height: 40)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(15)
                    }
                }
            }
            .padding(.horizontal, 10) // Extend buttons area slightly
            
        }
        .frame(width: 290) // Fixed width for background rectangle
        .padding()
        .background(Color.gray)
        .cornerRadius(20)
        .overlay(
            // Small triangle pointer below the pop-up
            Triangle()
                .fill(Color.gray.opacity(0.9))
                .frame(width: 20, height: 10)
                .rotationEffect(.degrees(180))
                .offset(y: 12),
            alignment: .bottom
        )
        .shadow(radius: 10)
    }
}

// Custom triangle shape to use as the pop-up pointer
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}


#Preview {
    MonumentDetail(
        isSheetPresented: .constant(false), isPresented: .constant(true),
        placeName: "Coliseo",
        onGetBadge: {
            print("Get Badge tapped")
        },
        onAddToWishlist: {
            print("Add to Wishlist tapped")
        }
    )
}
