//
//  VictoryScreenView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 18/01/2025.
//

import SwiftUI

struct VictoryScreenView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    var body: some View {
        HStack(spacing: 0) {
            PerPlayerVictoryScreenView(playerDelegateID: 0)
                .rotationEffect(.degrees(90))
                .environmentObject(globalData)
                .offset(x: globalData.currentScreen != .game ? 50 : -1000)
            
            PerPlayerVictoryScreenView(playerDelegateID: 1)
                .rotationEffect(.degrees(-90))
                .environmentObject(globalData)
                .offset(x: globalData.currentScreen != .game ? -50 : 1000)
        }
    }
}

#Preview {
    VictoryScreenView()
        .environmentObject(GlobalData())
}

