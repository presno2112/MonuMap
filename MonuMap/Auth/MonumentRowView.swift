//
//  MonumentRowView.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 15/11/24.
//

import SwiftUI

struct MonumentRowView: View {
    let monument: Monument

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(monument.name)
                    .foregroundStyle(.blue)
                    .font(.headline)

            }
        }
        .padding(.vertical, 4)
    }
}
//#Preview {
//    MonumentRowView()
//}
