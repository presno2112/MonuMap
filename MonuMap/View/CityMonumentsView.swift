//
//  CityMonumentsView.swift
//  MonuMap
//
//  Created by Gustavo Vasquez on 13/11/24.
//

import SwiftUI

struct MonumentView: View {
    var image: UIImage
    var title: String
    var description: String
    
    @State private var isHeartFilled = false // State to track heart status
    
    var body: some View {
        VStack(spacing: 8) { // Horizontal stack for image and text
            ZStack(alignment: .topTrailing) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 120) // Image size
                    .clipped()
                    .cornerRadius(8) // Optional: Corner radius for image
                
                Button(action: {
                    isHeartFilled.toggle()
                }) {
                    Image(systemName: isHeartFilled ? "heart.fill" : "heart") // Show filled or unfilled heart
                        .resizable()
                        .frame(width: 15, height: 15) // Adjust size of the heart icon
                        .foregroundColor(.blue) // Heart color
                        .padding(8) // Padding around the heart icon
                        .background(Color.white.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .lineLimit(1) // To ensure the title doesn't overflow
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(nil) // Allow multiple lines for the description
                    .multilineTextAlignment(.leading)
            }
            .padding([.leading, .trailing], 8)
        }
    }
}

struct CityMonumentsView: View {
    var cityName: String = "Napoli"
    var monuments: [(image: UIImage, title: String, description: String)] = [
        (UIImage(named: "coliseo")!, "Eiffel Tower", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum"),
        (UIImage(named: "coliseo")!, "Louvre Museum", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum"),
        (UIImage(named: "coliseo")!, "Notre Dame Cathedral", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum")
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            // City name at the top
            Text("Napoli")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 12)
                .frame(maxWidth: .infinity, alignment: .leading) // Left align the text
            
            // Horizontal scrollable carousel of monuments
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(monuments, id: \.title) { monument in
                        MonumentView(image: monument.image, title: monument.title, description: monument.description)
                            .frame(width: 200) // Fixed width for each "card"
                            .padding(.vertical, 10)
                    }
                }
                .padding(.horizontal, 16) // Padding around the carousel
            }
            .frame(height: 220) // Set a fixed height for the carousel
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    CityMonumentsView()
}
