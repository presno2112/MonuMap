//
//  MonumentDetail.swift
//  MonuMap
//
//  Created by Sebastian Presno on 13/11/24.
//

import SwiftUI

struct MonumentDetail: View {
    @Binding var isSheetPresented: Bool
    @Binding var isPresented: Bool
    let placeName: String
    var onGetBadge: () -> Void
    var onAddToWishlist: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 16) {
            // Header Text with Dynamic Font Adjustment
            ZStack {
                HStack {
                    Button {
                        isPresented = false
                        isSheetPresented = true
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(Color("font"))
                    }
                    .padding(.leading, 10)
                    
                    Spacer()
                }
                
                GeometryReader { geometry in
                    Text(placeName)
                        .font(.system(size: dynamicFontSize(for: placeName, availableWidth: geometry.size.width)))
                        .foregroundColor(Color("font"))
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: geometry.size.width, alignment: .center)
                }
                .frame(height: 30) // Ensure enough height for the text
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
                            .background(Color("MainBlue"))
                            .cornerRadius(15)
                    }
                    .padding(.bottom)
                    
                    Button(action: onAddToWishlist) {
                        Text("Add to wishlist")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 140, height: 40)
                            .background(Color("MainBlue"))
                            .cornerRadius(15)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .frame(width: 290)
        .padding()
        .background(Color("backgrounds"))
        .shadow(radius: 0.5)
        .cornerRadius(20)
        .overlay(
            Triangle()
                .fill(Color("backgrounds"))
                .frame(width: 20, height: 10)
                .rotationEffect(.degrees(180))
                .offset(y: 12),
            alignment: .bottom
        )
        .shadow(radius: 10)
    }
    
    /// Dynamically calculates the font size based on the text length and available width.
    private func dynamicFontSize(for text: String, availableWidth: CGFloat) -> CGFloat {
        let baseFontSize: CGFloat = 24 // Start with a base font size
        let maxWidthForBaseFont: CGFloat = 200 // Assumed width for the base font size
        let scaleFactor = min(1, availableWidth / maxWidthForBaseFont)
        return baseFontSize * scaleFactor
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
        placeName: "A Really Really Long Monument Name",
        onGetBadge: {
            print("Get Badge tapped")
        },
        onAddToWishlist: {
            print("Add to Wishlist tapped")
        }
    )
}

