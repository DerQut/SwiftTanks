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
    @Published var timer = Timer.publish(every: 1/120, on: .main, in: .common).autoconnect()
    
    @Published var currentScreen: GameScreen = .game
    
    @Published var mapSize: CGSize = CGSize(width: 920, height: 820)
    
    @Published var players: [Player?] = [nil, nil]
    @Published var bullets: [Bullet] = []
    @Published var walls: [Wall] = [
        Wall(position: CGPoint(x: -0.5 * 920 - 20, y: 0), size: CGSize(width: 40, height: 820+80)),
        Wall(position: CGPoint(x: 0.5 * 920 + 20, y: 0), size: CGSize(width: 40, height: 820+80)),
        Wall(position: CGPoint(x: 0, y: 0.5 * 820 + 20), size: CGSize(width: 920+80, height: 40)),
        Wall(position: CGPoint(x: 0, y: -0.5 * 820 - 20), size: CGSize(width: 920+80, height: 40))
    ]
    
    @Published var victoriousID: Int? = nil
    
    public let playerFacory = PlayerFactory()
    
    init() {
        self.players[0] = self.playerFacory.createPlayer(type: .fast, bulletType: .normal, color: .blue, position: CGPoint(x: -300, y: -300), angle: .zero)
        
        self.players[1] = self.playerFacory.createPlayer(type: .tanky, bulletType: .normal, color: .red, position: CGPoint(x: 300, y: 300), angle: .zero)
        
        self.walls.append(Wall(position: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 100)))
        
    }
    
    func getPlayers() -> [Player] {
        return self.players.compactMap {$0}
    }
    
    func moveEntities() {
        self.getPlayers().forEach {
            $0.position.x -= $0.velocity * sin($0.angle.radians)
            $0.position.y -= $0.velocity * cos($0.angle.radians)
        }
        
        self.bullets.forEach {
            $0.position.x -= $0.velocity * sin($0.angle.radians)
            $0.position.y -= $0.velocity * cos($0.angle.radians)
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
    
    func pushBulletsFromWalls() {
        self.bullets.forEach { bullet in
            self.walls.forEach { wall in
                let collisions = wall.checkIfCollided(with: bullet)
                
                if !collisions.isEmpty {
                    bullet.bouncesLeft -= 1
                    bullet.angle = .radians(bullet.angle.radians * (-1))
                    
                    if collisions.contains(.down) || collisions.contains(.up) {
                        bullet.angle = .degrees(180 + bullet.angle.degrees)
                    }
                    
                }
                
                if bullet.bouncesLeft < 0 {
                    self.bullets.removeAll { $0 === bullet }
                }
            }
        }
    }
    
    func fire(fromPlayerWithID id: Int) {
        if self.players[id] != nil {
            self.bullets.append(self.players[id]!.bulletFactory.createBullet(owner: self.players[id]!))
        }
    }
    
    func dealDamage() {
        self.getPlayers().forEach { player in
            let nearbyBullets = self.bullets.filter{$0.position.distance(to: player.position) < $0.size/2 + player.size/2}
            
            nearbyBullets.forEach { bullet in
                if bullet.owner !== player || bullet.bouncesLeft < bullet.maxBounces {
                    player.health -= bullet.damage
                    self.bullets.removeAll { $0 === bullet }
                }
            }
        }
    }
    
    func destroyBulletsTouchingOtherBullets() {
        
        var bulletsToBeDestroyed: [Bullet] = []
        
        self.bullets.forEach { firstBullet in
            self.bullets.filter {$0.position.distance(to: firstBullet.position) < $0.size/2 + firstBullet.size/2 && $0 !== firstBullet}.forEach { otherBullet in
                
                bulletsToBeDestroyed.append(otherBullet)
                bulletsToBeDestroyed.append(firstBullet)
            }
        }
        
        bulletsToBeDestroyed.forEach { bullet in
            self.bullets.removeAll { $0 === bullet }
        }
    }
    
    func killCheck() {
        self.getPlayers().forEach { player in
            if player.health <= 0 {
                self.currentScreen = .victoryScreen
            }
        }
        
        var i: Int = 0
        while i < self.getPlayers().count {
            if self.getPlayers()[i].health > 0 && victoriousID != nil {
                self.victoriousID = i
            } else {
                self.victoriousID = nil
            }
            i = i + 1
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
