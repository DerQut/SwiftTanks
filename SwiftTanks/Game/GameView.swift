//
//  GameView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        ZStack {
            MapView()
            
            HStack {
                PlayerControlView(forceAngleOffset: 0.0, playerDelegateID: 0)
                    .rotationEffect(.degrees(90))
                    .frame(height: 200)
                    .opacity(0.5)
                
                Spacer()
                    .frame(width: UIScreen.main.bounds.size.width-200)
            }
            
            HStack {
                Spacer()
                    .frame(width: UIScreen.main.bounds.size.width-200)
                
                PlayerControlView(forceAngleOffset: .pi, playerDelegateID: 1)
                    .rotationEffect(.degrees(-90))
                    .frame(height: 200)
                    .opacity(0.5)
            }
        }
    }
}
