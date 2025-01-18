//
//  SwiftTanksApp.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

class GlobalData: ObservableObject {
    @Published var isInMainMenu: Bool = false
    
    @Published var players: [Player?] = [
        Player(bulletType: .normal, color: .blue, maxSpeed: 10, position: CGPoint(x: 500, y: 500), angle: .degrees(0), health: 100),
        
        Player(bulletType: .normal, color: .red, maxSpeed: 10, position: CGPoint(x: 1300, y: 300), angle: .degrees(0), health: 100),
    ]
    @Published var bullets: [Bullet] = []
    
    func getPlayers() -> [Player] {
        return self.players.compactMap {$0}
    }
    
    func moveBullets() {
        self.bullets.forEach {
            $0.position.x += $0.velocity * cos($0.angle.radians)
            $0.position.y += $0.velocity * sin($0.angle.radians)
            print($0.position)
        }
    }
}

@main
struct SwiftTanksApp: App {
    var globalData: GlobalData = GlobalData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(globalData)
        }
    }
}
