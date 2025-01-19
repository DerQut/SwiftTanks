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

enum EngineError: Error {
    case invalidPlayerID
    case missingBulletFactory
}

class GlobalData: ObservableObject {
    @Published var timer = Timer.publish(every: 1/120, on: .main, in: .common).autoconnect()
    
    @Published var currentScreen: GameScreen = .mainMenu
    
    @Published var mapSize: CGSize = CGSize(width: 920, height: 820)
    
    @Published var players: [Player] = []
    @Published var bullets: [Bullet] = []
    @Published var walls: [Wall] = []
    
    @Published var playerHealthAtEndOfGame: [Double] = []
    
    @Published var playersReady: Int = 0
    
    public let playerFacory = PlayerFactory()
    
    public let playerSpawnPoints: [CGPoint] = [
        CGPoint(x: -300, y: -300),
        CGPoint(x: 300, y: 300)
    ]
    
    init() {
        self.players.append(self.playerFacory.createPlayer(type: .normal, bulletType: .normal, color: .blue, position: self.playerSpawnPoints[0], angle: .zero))
        
        self.players.append(self.playerFacory.createPlayer(type: .normal, bulletType: .normal, color: .red, position: self.playerSpawnPoints[1], angle: .zero))
        
        self.preloadBorderWalls()
        
        self.walls.append(Wall(position: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 100)))
        
    }
    
    func getPlayers() -> [Player] {
        return self.players.compactMap {$0}
    }
    
    func getWalls() -> [Wall] {
        return self.walls.compactMap {$0}
    }
    
    func getBullets() -> [Bullet] {
        return self.bullets.compactMap {$0}
    }
    
    func moveEntities() {
        self.getPlayers().forEach {
            $0.position.x -= $0.velocity * sin($0.angle.radians)
            $0.position.y -= $0.velocity * cos($0.angle.radians)
        }
        
        self.getBullets().forEach {
            $0.position.x -= $0.velocity * sin($0.angle.radians)
            $0.position.y -= $0.velocity * cos($0.angle.radians)
        }
    }
    
    func pushPlayersFromWalls() {
        self.getPlayers().forEach { player in
            self.getWalls().forEach { wall in
                var collisions = wall.checkIfCollided(with: player)
                while collisions.isEmpty == false {
                    
                    if collisions.contains(.left) {
                        player.position.x -= 0.25
                    }
                    else if collisions.contains(.right) {
                        player.position.x += 0.25
                    }
                    
                    if collisions.contains(.up) {
                        player.position.y += 0.25
                    }
                    else if collisions.contains(.down) {
                        player.position.y -= 0.25
                    }
                    collisions = wall.checkIfCollided(with: player)
                }
            }
        }
    }
    
    func pushBulletsFromWalls() {
        self.getBullets().forEach { bullet in
            self.getWalls().forEach { wall in
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
    
    func fire(fromPlayerWithID id: Int) throws {
        if id > self.getPlayers().endIndex {
            throw EngineError.invalidPlayerID
        }
        
        let player = self.getPlayers()[id]
        
        do {
            try self.bullets.append(player.createBullet())
        } catch EngineError.missingBulletFactory {
            print("Missing bullet factory for player with id \(id)")
        } catch {
            print("\(error)")
        }
    }
    
    func setAngle(_ angle: Angle, forPlayerWithID id: Int) throws {
        if id > self.getPlayers().endIndex {
            throw EngineError.invalidPlayerID
        }
        
        let player = self.getPlayers()[id]
        player.angle = angle
        
    }
    
    func setVelocity(_ velocity: CGFloat, forPlayerWithID id: Int) throws {
        if id > self.getPlayers().endIndex {
            throw EngineError.invalidPlayerID
        }
        
        let player = self.getPlayers()[id]
        player.velocity = velocity
    }
    
    func setVelocityRatio(_ velocityRatio: CGFloat, forPlayerWithID id: Int) throws {
        if id > self.getPlayers().endIndex {
            throw EngineError.invalidPlayerID
        }
        
        let player = self.getPlayers()[id]
        player.velocity = velocityRatio * player.maxSpeed
    }
    
    func dealDamage() {
        self.getPlayers().forEach { player in
            let nearbyBullets = self.getBullets().filter{$0.position.distance(to: player.position) < $0.size/2 + player.size/2}
            
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
        if !self.getPlayers().filter({$0.health <= 0}).isEmpty {
            self.playerHealthAtEndOfGame = self.getPlayers().map {$0.health}
            self.currentScreen = .victoryScreen
        }
    }
    
    func clearMap() {
        self.bullets.removeAll()
        self.walls.removeAll()
    }
    
    func preloadBorderWalls() {
        self.walls = [
            Wall(position: CGPoint(x: -0.5 * self.mapSize.width - 10, y: 0), size: CGSize(width: 20, height: self.mapSize.height+40)),
            
            Wall(position: CGPoint(x: 0.5 * self.mapSize.width + 10, y: 0), size: CGSize(width: 20, height: self.mapSize.height+40)),
            
            Wall(position: CGPoint(x: 0, y: 0.5 * self.mapSize.height + 10), size: CGSize(width: self.mapSize.width+40, height: 20)),
            
            Wall(position: CGPoint(x: 0, y: -0.5 * self.mapSize.height - 10), size: CGSize(width: self.mapSize.width+40, height: 20))
        ]
    }
    
    func rematch() {
        
        self.players[0].health = self.players[0].maxHealth
        self.players[0].position = self.playerSpawnPoints[0]
        self.players[0].angle = .zero
        
        self.players[1].health = self.players[1].maxHealth
        self.players[1].position = self.playerSpawnPoints[1]
        self.players[1].angle = .zero
        
        self.startGame()
    }
    
    func startGame() {
        self.clearMap()
        self.preloadBorderWalls()
        self.walls.append(Wall(position: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 100)))
        
        self.playersReady = 0
        
        self.currentScreen = .game
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
