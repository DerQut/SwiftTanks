//
//  MainMenuView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var globalData: GlobalData
    var body: some View {
        HStack(spacing: 0) {
            PlayerCreationView(playerDelegateID: 0)
                .rotationEffect(.degrees(90))
                .environmentObject(globalData)
                .offset(x: globalData.currentScreen != .game ? 50 : -1000)
                        
            PlayerCreationView(playerDelegateID: 1)
                .rotationEffect(.degrees(-90))
                .environmentObject(globalData)
                .offset(x: globalData.currentScreen != .game ? -50 : 1000)
        }
        .animation(.default, value: globalData.currentScreen)
        .onReceive(globalData.timer) { _ in
            if globalData.playersReady == 2 {
                globalData.startGame()
            }
        }
    }
}
