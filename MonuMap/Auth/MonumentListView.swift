//
//  MonumentListView.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 15/11/24.
//

import SwiftUI

//struct MonumentListView: View {
//    @StateObject private var viewModel = MonumentViewModel()
//
//    var body: some View {
//        NavigationView {
//            Group {
//                if viewModel.isLoading {
//                    ProgressView("Loading Monuments...")
//                } else if let errorMessage = viewModel.errorMessage {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                        .multilineTextAlignment(.center)
//                        .padding()
//                } else {
//                    List(viewModel.monuments) { monument in
//                        MonumentRowView(monument: monument)
//                    }
//                }
//            }
//            .navigationTitle("Monuments")
//            .onAppear {
//                Task {
//                    await viewModel.fetchMonuments()
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    MonumentListView()
//}
