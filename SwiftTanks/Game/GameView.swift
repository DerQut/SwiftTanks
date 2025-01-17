//
//  GameView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var globalData: GlobalData
    var body: some View {
        ZStack {
            MapView()
            
            HStack {
                PlayerControlView(forceAngleOffset: .pi, playerDelegateID: 0)
                    .rotationEffect(.degrees(90))
                    .frame(height: 200)
                    .opacity(0.7)
                
                Spacer()
                    .frame(width: UIScreen.main.bounds.size.width-200)
            }
            
            HStack {
                Spacer()
                    .frame(width: UIScreen.main.bounds.size.width-200)
                
                PlayerControlView(forceAngleOffset: 0.0, playerDelegateID: 1)
                    .rotationEffect(.degrees(-90))
                    .frame(height: 200)
                    .opacity(0.7)
            }
        }
        .onReceive(globalData.timer) { _ in
            if globalData.currentScreen == .game {
                
                globalData.replenishFrames()
                globalData.moveEntities()
                
                globalData.pushPlayersFromWalls()
                globalData.pushBulletsFromWalls()
                
                globalData.destroyBulletsTouchingOtherBullets()
                globalData.dealDamage()
                
                globalData.killCheck()
                
                globalData.updateView()
            }
        }
    }
}
