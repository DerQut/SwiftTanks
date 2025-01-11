//
//  ContentView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State var isInMainMenu: Bool = false
    
    var body: some View {
        if isInMainMenu {
            MainMenuView()
        } else {
            GameView()
        }
    }
}

#Preview {
    ContentView()
}
