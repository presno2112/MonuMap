//
//  LogoNName.swift
//  MonuMap
//
//  Created by Sebastian Presno on 12/11/24.
//

import SwiftUI

struct LogoNName: View {
    var body: some View {
        VStack{
            //TODO : Add logo instead of circle
            Circle()
                .frame(width: 150, height: 150)
                .foregroundStyle(.blue)
            
            Text("MonuMap")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    LogoNName()
}
