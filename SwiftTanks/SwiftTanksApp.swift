//
//  SwiftTanksApp.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

class GlobalData: ObservableObject {
    @Published var timer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
    
    @Published var isInMainMenu: Bool = false
    
    @Published var mapSize: CGSize = CGSize(width: 1024, height: 768)
    
    @Published var players: [Player?] = [
        Player(bulletType: .normal, color: .blue, maxSpeed: 10, position: CGPoint(x: 0, y: 0), angle: .degrees(0), health: 100),
        
        Player(bulletType: .normal, color: .red, maxSpeed: 10, position: CGPoint(x: 300, y: 300), angle: .degrees(0), health: 100),
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
    
    func movePlayers() {
        self.getPlayers().forEach {
            if (abs($0.position.x)+25 < self.mapSize.width/2) || ($0.position.x * sin($0.angle.radians) >= 0) {
                $0.position.x -= $0.velocity * sin($0.angle.radians)
            }
            
            if (abs($0.position.y)+25 < self.mapSize.height/2) || ($0.position.y * cos($0.angle.radians) >= 0) {
                $0.position.y -= $0.velocity * cos($0.angle.radians)
            }
        }
    }
    
    func updateView() {
        self.objectWillChange.send()
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
