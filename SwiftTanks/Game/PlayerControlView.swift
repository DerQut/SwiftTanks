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
                    .offset(x: 75, y: 75)
                Spacer()
                Text("PlayerControlView")
            }.padding()
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
