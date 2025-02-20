//
//  SettingsView.swift
//  TastyHub
//
//  Created by Роман  on 20.02.2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Настройки")
                    .font(.largeTitle)
                    .padding()
                
                Button("Выйти") {
                    
                }
                .foregroundColor(.red)
                .padding()
            }
        }
    }
}


#Preview {
    SettingsView()
}
