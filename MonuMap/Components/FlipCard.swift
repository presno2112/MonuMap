//
//  FlipCard.swift
//  MapKitTest
//
//  Created by Sebastian Presno on 06/11/24.
//

import SwiftUI

struct FlipCard: View {
    @Binding var showCard: Bool
    @State private var isFlipped: Bool = false
    @State var isInfoPressed : Bool = false
    
    var body: some View {
        ZStack{
            Color.blue
                .opacity(0.5)
                .blur(radius: 50)
            VStack{
                Spacer()
                ZStack {
                    Image(isFlipped ? "Image 1" : "Image 1")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .shadow(color: .gray, radius: 10)
                        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeInOut(duration: 0.6), value: isFlipped)
                        .onTapGesture {
                            isFlipped.toggle()
                        }
                        .blur(radius: isInfoPressed ? 70 : 0)
                        .disabled(isInfoPressed)
                    VStack{
                        Spacer()
                        // Button positioned using an overlay
                        HStack{
                            Spacer()
                            Button {
                                isInfoPressed.toggle()
                            } label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .opacity(0.8)
                            }
                            .padding(16)
                        }
                    }
                    Text("This is a very simple description to talk about the colosseum")
                        .multilineTextAlignment(.center)
                        .opacity(isInfoPressed ? 1 : 0)
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.horizontal, 16)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 300, height: 400)
                Spacer()
                HStack {
                    Spacer()
                    VStack{
                        Button{
                            
                        }label: {
                            ZStack {
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundStyle(.gray).opacity(0.5)
                                Image(systemName: "arrow.down.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                            }
                        }
                        Text("Download")
                    }
                    Spacer()
                    VStack{
                    Button{
                        
                    }label: {
                        ZStack {
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundStyle(.gray).opacity(0.5)
                            Image(systemName: "plus.circle.dashed")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                    }
                        Text("Share")
                }
                    Spacer()
                }
                .padding(.bottom, 90)
            }
            .padding(.top, 80)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FlipCard(showCard: .constant(true))
}
