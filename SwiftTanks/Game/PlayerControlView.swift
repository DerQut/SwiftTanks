//
//  PlayerControlView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

struct PlayerControlView: View {
    var body: some View {
        ZStack {
            Color(.gray)
            HStack {
                JoyStickView()
                    .offset(x: 83, y: 83)
                Spacer()
                Text("PlayerControlView")
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
        PlayerControlView()
            .opacity(0.5)
            .frame(height: 200)
    }
}
