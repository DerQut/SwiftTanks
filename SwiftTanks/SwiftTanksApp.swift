//
//  SwiftTanksApp.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

enum GameScreen {
    case mainMenu
    case game
    case victoryScreen
}

class GlobalData: ObservableObject {
    @Published var timer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
    
    @Published var currentScreen: GameScreen = .game
    
    @Published var mapSize: CGSize = CGSize(width: 1024, height: 768)
    
    @Published var players: [Player?] = [nil, nil]
    @Published var bullets: [Bullet] = []
    @Published var walls: [Wall] = []
    
    public let playerFacory = PlayerFactory()
    
    init() {
        self.players[0] = self.playerFacory.createPlayer(type: .fast, bulletType: .normal, color: .blue, position: CGPoint(x: -300, y: -300), angle: .zero)
        
        self.players[1] = self.playerFacory.createPlayer(type: .tanky, bulletType: .normal, color: .red, position: CGPoint(x: 300, y: 300), angle: .zero)
        
        self.walls.append(Wall(position: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 100)))
    }
    
    func getPlayers() -> [Player] {
        return self.players.compactMap {$0}
    }
    
    func moveBullets() {
        self.bullets.forEach {
            $0.position.x += $0.velocity * cos($0.angle.radians)
            $0.position.y += $0.velocity * sin($0.angle.radians)
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
    
    func pushPlayersFromWalls() {
        self.getPlayers().forEach { player in
            self.walls.forEach { wall in
                var collisions = wall.checkIfCollided(with: player)
                while collisions.isEmpty == false {
                    
                    if collisions.contains(.left) {
                        player.position.x -= 0.5
                    }
                    else if collisions.contains(.right) {
                        player.position.x += 0.5
                    }
                    
                    if collisions.contains(.up) {
                        player.position.y += 0.5
                    }
                    else if collisions.contains(.down) {
                        player.position.y -= 0.5
                    }
                    collisions = wall.checkIfCollided(with: player)
                }
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
