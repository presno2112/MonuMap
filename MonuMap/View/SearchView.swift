//
//  SearchView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 07/11/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var isSheetPresented: Bool
    @State var searchText: String = ""
    @State private var currentHeight: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack {
                    SearchBar()
                        .padding(.leading)
                    Button {
                        
                    } label: {
                        Image(systemName: "camera.circle.fill")
                            .font(.largeTitle)
                    }
                    .padding()
                }
                .padding(.horizontal)
                .padding(.top, currentHeight <= 50 ? 0 : 10)
                Spacer()
            }
            .onAppear {
                currentHeight = geometry.size.height
            }
            .onChange(of: geometry.size.height) { newHeight in
                currentHeight = newHeight
            }
        }
    }
}


#Preview {
    SearchView(isSheetPresented: .constant(true))
}
