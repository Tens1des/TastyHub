//
//  ContentView.swift
//  TastyHub
//
//  Created by Роман  on 11.12.2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated = false // Состояние входа

    var body: some View {
        if isAuthenticated {
            MainTabView() // После входа показывается главный экран с вкладками
        } else {
            AuthView(onLoginSuccess: {
                isAuthenticated = true // Устанавливаем, что пользователь вошел
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


