//
//  PolaroidView.swift
//  MonuMap
//
//  Created by Gustavo Vasquez on 13/11/24.
//

import SwiftUI

struct PolaroidView: View {
    var image: UIImage = UIImage(named: "black_test")!
    var title: String = "Monument"
    var description: String = "Monument Description"
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 180)
                .cornerRadius(15)
                .clipped()
            
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 4)
                .multilineTextAlignment(.leading) // Left align the description
                .lineLimit(nil) // Prevent truncation (allow wrapping)
                .fixedSize(horizontal: false, vertical: true) // Allow the text to expand vertically
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 5))
    }
}

#Preview {
    PolaroidView()
}
