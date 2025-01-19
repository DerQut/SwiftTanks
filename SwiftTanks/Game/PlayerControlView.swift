//
//  PlayerControlView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

struct PlayerControlView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    let forceAngleOffset: CGFloat
    let playerDelegateID: Int
    
    public var body: some View {
        ZStack {
            Color(.gray)

                JoyStickView(forceAngleOffset: forceAngleOffset, playerDelegateID: playerDelegateID)
                    .offset(x: 83, y: 83)
            HStack {
                Circle()
                    .frame(width: 150, height: 150)
                    .offset(x: -9)
                    .opacity(0.0)
                
                Spacer()
                
                ProgressView(value: globalData.players[playerDelegateID].health, total: globalData.players[playerDelegateID].maxHealth)
                    .frame(width: globalData.players[playerDelegateID].maxHealth)
                    .scaleEffect(x: 3, y: 15)
                    .tint(globalData.players[self.playerDelegateID].color)

                
                Spacer()
                
                Button("O") {
                    do {
                        try globalData.fire(fromPlayerWithID: playerDelegateID)
                    } catch EngineError.invalidPlayerID {
                        print("EngineError.invalidPlayerID error in PlayerControlView")
                    } catch {
                        print("Unknown error in PlayerControlView")
                    }
                }
                .font(.largeTitle)
                .buttonStyle(.borderedProminent)
                .frame(width: 150)
                
            }
            .frame(width: UIScreen.main.bounds.size.width/1.5)
            .padding()
        }
    }
}

#Preview {
    ZStack {
        Color(.white)
            .ignoresSafeArea()
        PlayerControlView(forceAngleOffset: 0.0, playerDelegateID: 0)
            .opacity(0.5)
            .frame(height: 200)
    }
}
