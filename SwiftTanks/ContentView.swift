//
//  ContentView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State var mode: Int = 1
    
    var body: some View {
        if mode == 1 {
            GameView()
        }
    }
}

#Preview {
    ContentView()
}
