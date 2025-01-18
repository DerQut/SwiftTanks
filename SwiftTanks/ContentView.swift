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
                .onReceive(globalData.timer) { _ in
                    if !globalData.isInMainMenu {
                        globalData.moveBullets()
                        globalData.movePlayers()
                        globalData.updateView()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalData())
}
