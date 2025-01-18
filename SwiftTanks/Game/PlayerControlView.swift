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
            HStack {
                JoyStickView(forceAngleOffset: forceAngleOffset, playerDelegateID: playerDelegateID)
                    .offset(x: 83, y: 83)
                Spacer()
                
                Button("O") {
                    globalData.fire(fromPlayerWithID: playerDelegateID)
                }
                .font(.largeTitle)
                .buttonStyle(.borderedProminent)
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
