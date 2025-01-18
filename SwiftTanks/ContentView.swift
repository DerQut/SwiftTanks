//
//  ContentView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var globalData: GlobalData
        
    var body: some View {
        if globalData.isInMainMenu {
            MainMenuView()
        } else {
            GameView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalData())
}
